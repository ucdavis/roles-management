class GroupMemberAssignment < ActiveRecord::Base
  using_access_control

  validates_presence_of :group, :entity
  validate :group_cannot_join_itself

  belongs_to :group
  belongs_to :entity

  private

  # Ensure a group does not attempt to join (member) itself
  def group_cannot_join_itself
    if !group.blank? and group == entity
      errors[:base] << "Group cannot join with itself"
    end
  end
end
