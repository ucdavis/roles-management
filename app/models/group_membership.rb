# Represents an explicit GroupMembership.
# Note that 'implicit' or 'calculated' group memberships also exist to represent those
# belonging to a group via a GroupRule. 'Implicit' or 'calculated' group memberships are
# calculated in Group.members() and are not stored in GroupMembership objects.
class GroupMembership < ApplicationRecord
  validates_presence_of :group, :entity
  validates_uniqueness_of :group_id, scope: :entity_id
  validate :members_cannot_be_other_groups

  belongs_to :group, touch: true
  belongs_to :entity, touch: true

  private

  def members_cannot_be_other_groups
    errors.add(:base, 'groups cannot be members of other groups') if entity&.type == 'Group'
  end
end
