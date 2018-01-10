# A role has both 'entities' and 'members'.
# Ultimately, 'entities' is the only model assigned to a role.
# An entity is either a Person or Group.
# 'Members' refers only to people and is calculated by flattening
# groups down to people.
class Role < ApplicationRecord
  # SYNC_ROLE_ATTRS is the list of role attribtues we care to notify
  # the sync subsystem about.
  SYNC_ROLE_ATTRS = %w[ad_path token name description].freeze

  validates :application_id, presence: true
  validates :token, uniqueness: { scope: :application_id, message: 'token must be unique per application' }
  validate :ad_path_cannot_be_blank_if_present

  has_many :role_assignments, dependent: :destroy
  has_many :entities, through: :role_assignments

  belongs_to :application, touch: true

  after_save :trigger_sync_if_changed

  # Role activity is tagged under the application the role belongs to.
  after_create do |role|
    ActivityLog.info!("Created role #{role.token}.", ["application_#{role.application_id}"])
  end
  after_destroy do |role|
    ActivityLog.info!("Deleted role #{role.token}.", ["application_#{role.application_id}"])
  end

  # DO NOT add entity_ids to this list - removing entities that way goes through
  # a has_many :through and will _not_ trigger important before_destroy callbacks in RoleAssignment.
  # This is noted in the Rails documentation. Remove entities via roles_attributes.
  accepts_nested_attributes_for :role_assignments, allow_destroy: true

  def name_with_application
    "#{application.name} / #{name}"
  end

  # Returns identifying string for logging purposes. Other classes implement this too.
  # Format: (Class name:id,identifying fields)
  def log_identifier
    "(Role:#{id},#{application.name}/#{token})"
  end

  def to_csv
    members.select(&:active).map { |m| [token, m.id, m.loginid, m.email, m.first, m.last] }
  end

  # Different from entities, 'members' takes all people and all people from groups
  # (flattens the group) and returns them as a list. It also only returns unique results,
  # so e.g. if a person has this role via two different groups, they will only appear once
  # in the members output, but at least twice in the 'entities' output.
  def members
    all = []

    # Add all people
    all += entities.where(type: 'Person').to_a

    # Add all group members
    entities.where(type: 'Group').to_a.each do |group|
      all += group.members
    end

    # Return a unique list
    all.uniq(&:id)
  end

  private

  def ad_path_cannot_be_blank_if_present
    self.ad_path = nil if ad_path && ad_path.blank?
  end

  def trigger_sync_if_changed
    return if (saved_changes.keys & SYNC_ROLE_ATTRS).empty?

    Sync.role_changed(Sync.encode(self, true)
        .merge(changes: saved_changes.select { |c, _v| SYNC_ROLE_ATTRS.include?(c) }))
  end
end
