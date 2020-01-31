# A role has both 'entities' and 'members'.
# Ultimately, 'entities' is the only model assigned to a role.
# An entity is either a Person or Group.
# 'Members' refers only to people and is calculated by flattening groups down to people.
class Role < ApplicationRecord
  validates :application_id, presence: true
  validates :token, uniqueness: { scope: :application_id, message: 'token must be unique per application' }
  validate :ad_path_cannot_be_blank_if_present

  has_many :role_assignments, dependent: :destroy
  has_many :entities, through: :role_assignments

  belongs_to :application, touch: true

  def name_with_application
    "#{application.name} / #{name}"
  end

  # Returns identifying string for logging purposes. Other classes implement this too.
  # Format: (Class name:id,identifying fields)
  def log_identifier
    "(Role:#{id},#{application.name}/#{token})"
  end

  def to_csv
    members(only_active: true).map { |m| [token, m.id, m.loginid, m.email, m.first, m.last] }
  end

  # Different from entities, 'members' takes all people and all people from groups
  # (flattens the group) and returns them as a list. It also only returns unique results,
  # so e.g. if a person has this role via two different groups, they will only appear once
  # in the members output, but at least twice in the 'entities' output.
  def members(only_active: false)
    all = []

    # Add all people
    all += entities.where(type: 'Person').to_a

    # Add all group members
    entities.where(type: 'Group').to_a.each do |group|
      all += group.members
    end

    return all.uniq(&:id).select(&:active) if only_active

    # Return a unique list
    all.uniq(&:id)
  end

  private

  def ad_path_cannot_be_blank_if_present
    self.ad_path = nil if ad_path && ad_path.blank?
  end
end
