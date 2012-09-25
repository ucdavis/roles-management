class GroupOperatorAssignments < ActiveRecord::Base
  using_access_control

  validates_presence_of :group
  validate :person_or_group_is_present
  validate :group_cannot_operate_itself

  belongs_to :group
  belongs_to :operator_person, :class_name => "Person"
  belongs_to :operator_group, :class_name => "Group"

  private

  # owner_person or owner_group has to be set, but not both
  def person_or_group_is_present
    if !(operator_person.blank? ^ operator_group.blank?)
      errors[:base] << "Specify an operator person or group, not both"
    end
  end

  # Ensure a group does not attempt to operate itself
  def group_cannot_operate_itself
    if !group.blank? and group == operator_group
      errors[:base] << "Group cannot operate itself"
    end
  end
end
