class GroupOwnerAssignment < ActiveRecord::Base
  using_access_control

  validates_presence_of :group, :entity
  validate :group_cannot_own_itself

  belongs_to :group
  belongs_to :entity

  private

  # Ensure a group does not attempt to own itself
  def group_cannot_own_itself
    if !group.blank? and group == entity
      errors[:base] << "Group cannot own itself"
    end
  end
end
