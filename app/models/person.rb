require 'sync'

# Person shares many attributes with entity.
# Note that the 'name' field is simply self.first + " " + self.last
# and is thus read-only. The same does not apply for groups.
class Person < Entity
  include RmBuiltinRoles

  has_many :affiliation_assignments, dependent: :destroy
  has_many :affiliations, through: :affiliation_assignments
  has_many :group_memberships, foreign_key: 'entity_id', dependent: :destroy
  has_many :groups, through: :group_memberships, source: :group
  has_many :role_assignments, foreign_key: 'entity_id', dependent: :destroy
  has_many :roles, through: :role_assignments, source: :role, dependent: :destroy
  has_many :favorite_relationships, class_name: 'PersonFavoriteAssignment', foreign_key: 'owner_id', dependent: :destroy
  has_many :favorites, through: :favorite_relationships, source: :entity
  has_many :application_ownerships, foreign_key: 'entity_id', dependent: :destroy
  has_many :application_operatorships, foreign_key: 'entity_id', dependent: :destroy
  has_many :group_operatorships, foreign_key: 'entity_id', dependent: :destroy
  has_many :group_ownerships, foreign_key: 'entity_id', dependent: :destroy
  has_one :student

  belongs_to :title, optional: true
  belongs_to :major, optional: true

  accepts_nested_attributes_for :group_ownerships, allow_destroy: true
  accepts_nested_attributes_for :group_operatorships, allow_destroy: true
  accepts_nested_attributes_for :group_memberships, allow_destroy: true
  accepts_nested_attributes_for :role_assignments, allow_destroy: true

  validates :loginid, presence: true, uniqueness: true

  before_save  :set_name_if_blank
  after_save   :recalculate_group_rule_membership
  after_save   :trigger_sync_as_needed

  before_destroy :allow_group_membership_destruction, prepend: true

  after_create do |person|
    ActivityLog.info!("Created person #{person.name}.", ["person_#{person.id}", 'system'])
    Sync.person_added_to_system(Sync.encode(person))
  end
  after_destroy do |person|
    GroupMembership.can_destroy_calculated_group_membership(false)
    ActivityLog.info!("Deleted person #{person.name}.", ["person_#{person.id}", 'system'])
    Sync.person_removed_from_system(Sync.encode(person))
  end

  def as_json(_options)
    { id: id, name: name, type: 'Person', email: email,
      loginid: loginid, first: first, last: last,
      phone: phone, address: address,
      byline: byline, active: active,
      role_assignments: role_assignments.includes(:role).map { |a| {
        id: a.id, calculated: a.parent_id?, entity_id: a.entity_id,
        role_id: a.role.id, token: a.role.token,
        application_name: a.role.application.name, application_id: a.role.application_id,
        name: a.role.name, description: a.role.description }
      },
      favorites: favorites.select{ |f| f.active == true }.map{ |f| { id: f.id, name: f.name, type: f.type } },
      group_memberships: group_memberships.includes(:group).map{ |m| {
        id: m.id, group_id: m.group.id, name: m.group.name, calculated: m.calculated }
      },
      group_ownerships: group_ownerships.includes(:group).map { |o| {
        id: o.id, group_id: o.group.id, name: o.group.name }
      },
      group_operatorships: group_operatorships.includes(:group).map { |o| {
        id: o.id, group_id: o.group.id, name: o.group.name }
      },
      organizations: organizations.map{ |o| { id: o.id, name: o.name } }
    }
  end

  # For CSV export
  def self.csv_header
    'ID,Login ID,Email,First,Last'.split(',')
  end

  def to_csv
    [id, loginid, email, first, last]
  end

  # Returns identifying string for logging purposes. Other classes implement this too.
  # Format: (Class name:id,identifying fields)
  def log_identifier
    "(Person:#{id},#{loginid},#{name})"
  end

  # Calculates 'byline' for a Person, e.g. "PROGRAMMER V (staff:career)"
  def byline
    byline = title&.name.to_s
    byline += ' (' + affiliations.map(&:name).join(', ') + ')' if affiliations.count.positive?
    byline
  end

  # Compute their classifications based on their title
  def classifications
    title.classifications
  end

  # Returns a list of symbols as required by the authorization layer.
  # Currently only have :access and :admin. Note that an :admin user will have both due to :admin
  # being merely an extension on top of permissions already granted via :access.
  def role_symbols
    roles.select { |r| rm_roles_ids.include? r.id }.map { |r| r.token.underscore.to_sym }.uniq
  end

  # Returns true if this person has access to the RM application in any form
  def has_access?
    role_symbols.include?(:admin) || role_symbols.include?(:access)
  end

  def is_admin?
    role_symbols.include?(:admin)
  end

  def is_operator?
    role_symbols.include?(:operate)
  end

  # Returns all applications visible to a user
  def accessible_applications
    applications = []

    ApplicationOwnership.eager_load(:application).where(entity_id: id).each do |ao|
      applications << ao.application
    end
    ApplicationOperatorship.eager_load(:application).where(entity_id: id).each do |ao|
      applications << ao.application
    end

    groups.each do |g|
      ApplicationOwnership.eager_load(:application).where(entity_id: g.id).each do |ao|
        applications << ao.application
      end
      ApplicationOperatorship.eager_load(:application).where(entity_id: g.id).each do |ao|
        applications << ao.application
      end
    end

    applications.uniq
  end

  # Returns all applications the user has an ownership or operatorship on
  def manageable_applications
    if role_symbols.include?(:admin) || role_symbols.include?(:operate)
      Application.includes(:roles, :application_ownerships, :operatorships).all
    else
      application_ids = (application_ownerships.map(&:application_id) + application_operatorships.map(&:application_id)).uniq
      Application.includes(:roles, :application_ownerships, :operatorships).where(id: application_ids)
    end
  end

  def recalculate_group_rule_membership
    if saved_change_to_attribute?(:title_id)
      GroupRule.resolve_target!(:title, id)
      GroupRule.resolve_target!(:classification, id)
    end
    if saved_change_to_attribute?(:major_id)
      GroupRule.resolve_target!(:major, id)
    end
    if saved_change_to_attribute?(:loginid)
      GroupRule.resolve_target!(:loginid, id)
    end
  end

  private

  # If a person goes from inactive to active, we need to ensure
  # any role_assignment or group views are touched correctly.
  def trigger_sync_as_needed
    if saved_change_to_attribute?(:active)
      role_assignments.each(&:touch)
      group_memberships.each(&:touch)
      organizations.each(&:touch)

      # Activating/de-activating a person emulates them losing all their
      # roles and organizations
      if active
        ActivityLog.info!("Marking as active for #{name}.", ["person_#{id}"])

        roles.each do |role|
          Sync.person_added_to_role(Sync.encode(self), Sync.encode(role))
        end
        organizations.each do |organization|
          Sync.person_added_to_organization(Sync.encode(self), Sync.encode(organization))
        end

        Sync.person_added_to_system(Sync.encode(self))
      else
        ActivityLog.info!("Marking as inactive for #{name}.", ["person_#{id}"])

        roles.each do |role|
          Sync.person_removed_from_role(Sync.encode(self), Sync.encode(role))
        end
        organizations.each do |organization|
          Sync.person_removed_from_organization(Sync.encode(self), Sync.encode(organization))
        end

        Sync.person_removed_from_system(Sync.encode(self))
      end
    end
  end

  # If name is unset, construct it from first + last.
  # If that fails, use loginid.
  def set_name_if_blank
    return unless name.blank?

    if first.blank?
      self.name = loginid
    else
      self.name = "#{first} #{last}".strip
    end
  end

  def allow_group_membership_destruction
    # Destroying a person may involve the valid case of destroying
    # calculated group memberships.
    GroupMembership.can_destroy_calculated_group_membership(true)
  end
end
