require 'benchmark'
require 'sync'

# Person shares many attributes with entity.
# Note that the 'name' field is simply self.first + " " + self.last
# and is thus read-only. The same does not apply for groups.
class Person < Entity
  include RmBuiltinRoles

  scope :active, -> { where active: true }
  scope :inactive, -> { where active: false }

  has_many :group_memberships, foreign_key: 'entity_id', dependent: :destroy
  has_many :role_assignments, foreign_key: 'entity_id', dependent: :destroy
  has_many :roles, through: :role_assignments, source: :role, dependent: :destroy
  has_many :favorite_relationships, class_name: 'PersonFavoriteAssignment',
                                    foreign_key: 'owner_id', dependent: :destroy
  has_many :favorites, through: :favorite_relationships, source: :entity
  has_many :application_ownerships, foreign_key: 'entity_id', dependent: :destroy
  has_many :application_operatorships, foreign_key: 'entity_id', dependent: :destroy
  has_many :group_operatorships, foreign_key: 'entity_id', dependent: :destroy
  has_many :group_ownerships, foreign_key: 'entity_id', dependent: :destroy
  has_many :sis_associations, foreign_key: 'entity_id', dependent: :destroy
  has_many :majors, through: :sis_associations, dependent: :destroy
  has_many :pps_associations, dependent: :destroy
  has_many :group_rule_results, foreign_key: 'entity_id'

  accepts_nested_attributes_for :group_ownerships, allow_destroy: true
  accepts_nested_attributes_for :group_operatorships, allow_destroy: true
  accepts_nested_attributes_for :group_memberships, allow_destroy: true
  accepts_nested_attributes_for :role_assignments, allow_destroy: true

  validates :loginid, presence: true, uniqueness: true

  before_save  :set_name_if_blank
  before_save  :ensure_utf8
  after_save   :recalculate_group_rule_membership
  after_save   :log_changes

  after_create do |person|
    ActivityLog.info!("Created person #{person.name}.", ["person_#{person.id}", 'system'])
    Sync.person_added_to_system(Sync.encode(person))
  end
  after_destroy do |person|
    ActivityLog.info!("Deleted person #{person.name}.", ["person_#{person.id}", 'system'])
    Sync.person_removed_from_system(Sync.encode(person))
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

  # Calculates 'byline' for a Person, e.g. "PROGRAMMER V (DSS IT)"
  def byline
    [
      pps_associations.map { |assoc| "#{assoc.title.name} (#{assoc.department.displayName})" },
      sis_associations.map { |assoc| "#{assoc.major.name} (#{assoc.level_code})" }
    ]&.flatten&.join(', ')
  end

  # Returns a list of symbols as required by the authorization layer.
  # Currently only have :access and :admin. Note that an :admin user will have both due to :admin
  # being merely an extension on top of permissions already granted via :access.
  def role_symbols
    roles.select { |r| rm_roles_ids.include? r.id }.map { |r| r.token.underscore.to_sym }.uniq
  end

  # Returns true if this person has access to the RM application in any form
  def has_access? # rubocop:disable Naming/PredicateName
    role_symbols.include?(:admin) || role_symbols.include?(:access)
  end

  def is_admin? # rubocop:disable Naming/PredicateName
    role_symbols.include?(:admin)
  end

  def is_operator? # rubocop:disable Naming/PredicateName
    role_symbols.include?(:operate)
  end

  # Return groups to which this person belongs, explicitly
  # or via group rules. Use only_via_rules = true to exclude
  # explicit memberships.
  def groups(only_via_rules = false)
    _groups = []

    time = Benchmark.measure do
      _groups = Rails.cache.fetch("person/#{id}/groups/#{updated_at.to_f}/#{only_via_rules}") do
        group_ids = GroupsService.rule_memberships_for_person(id)
        group_ids += group_memberships.select(:group_id).pluck(:group_id) unless only_via_rules
        Group.where(id: group_ids.uniq)
      end
    end

    Rails.logger.warn "Person.groups for person with ID #{id} took #{time.real}" if time.real > 0.50

    return _groups
  end

  # Returns all applications visible to a user
  def accessible_applications # rubocop:disable Metrics/AbcSize
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
      Application.includes(:roles, application_ownerships: [:entity]).all
    else
      application_ids = (application_ownerships.map(&:application_id) +
                         application_operatorships.map(&:application_id)).uniq
      Application.includes(:roles, application_ownerships: [:entity]).where(id: application_ids)
    end
  end

  def recalculate_group_rule_membership
    GroupRulesService.update_results_for(:loginid, self) if saved_change_to_attribute?(:loginid)
    GroupRulesService.update_results_for(:is_staff, self) if saved_change_to_attribute?(:is_staff)
    GroupRulesService.update_results_for(:is_student, self) if saved_change_to_attribute?(:is_student)
    GroupRulesService.update_results_for(:is_employee, self) if saved_change_to_attribute?(:is_employee)
    GroupRulesService.update_results_for(:is_faculty, self) if saved_change_to_attribute?(:is_faculty)
    GroupRulesService.update_results_for(:is_hs_employee, self) if saved_change_to_attribute?(:is_hs_employee)
    GroupRulesService.update_results_for(:is_external, self) if saved_change_to_attribute?(:is_external)
  end

  private

  # If name is unset, construct it from first + last.
  # If that fails, use loginid.
  def set_name_if_blank
    return unless name.blank?
    self.name = first.blank? ? loginid : "#{first} #{last}".strip
  end

  # current mysql db uses 3-byte unicode encoding, strip any overflowing characters
  def ensure_utf8
    if self.name
      self.name = self.name.each_char.select { |c| c.bytes.size < 4 }.join('')
    end

    if self.first
      self.first = self.first.each_char.select { |c| c.bytes.size < 4 }.join('')
    end

    if self.last
      self.last = self.last.each_char.select { |c| c.bytes.size < 4 }.join('')
    end
  end

  def log_changes # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    saved_changes.each do |field, changes|
      next if field == 'updated_at'
      next if field == 'synced_at'
      next if field == 'created_at'
      next if field == 'logged_in_at'
      next if field == 'type'
      next if field == 'id'
      next if changes[0].blank? && changes[1].blank?
      Rails.logger&.debug "\t#{field}: '#{changes[0]}' -> '#{changes[1]}'"
      case field
      when 'first'
        ActivityLog.info!("First name changed from '#{changes[0]}' to '#{changes[1]}'", ["person_#{id}"])
      when 'last'
        ActivityLog.info!("Last name changed from '#{changes[0]}' to '#{changes[1]}'", ["person_#{id}"])
      when 'phone'
        ActivityLog.info!("Phone number changed from '#{changes[0]}' to '#{changes[1]}'", ["person_#{id}"])
      when 'name'
        ActivityLog.info!("Name changed from '#{changes[0]}' to '#{changes[1]}'", ["person_#{id}"])
      when 'loginid'
        ActivityLog.info!("Login ID changed from '#{changes[0]}' to '#{changes[1]}'", ["person_#{id}"])
      when 'email'
        ActivityLog.info!("E-mail changed from '#{changes[0]}' to '#{changes[1]}'", ["person_#{id}"])
      else
        ActivityLog.info!("Attribute update: '#{field}': '#{changes[0]}' -> '#{changes[1]}'", ["person_#{id}"])
      end
    end
  end
end
