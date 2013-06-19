class GroupOperatorship < ActiveRecord::Base
  using_access_control

  validates_presence_of :group, :entity
  validate :group_cannot_operate_itself

  belongs_to :group
  belongs_to :entity

  private

  # Ensure a group does not attempt to operate itself
  def group_cannot_operate_itself
    if !group.blank? and group == entity
      errors[:base] << "Group cannot operate itself"
    end
  end
end
