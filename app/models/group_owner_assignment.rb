class GroupOwnerAssignment < ActiveRecord::Base
  using_access_control

  validates_presence_of :group
  validate :person_or_group_is_present
  validate :group_cannot_own_itself

  belongs_to :group
  belongs_to :owner_person, :class_name => "Person"
  belongs_to :owner_group, :class_name => "Group"

  private

  # owner_person or owner_group has to be set, but not both
  def person_or_group_is_present
    if !(owner_person.blank? ^ owner_group.blank?)
      errors[:base] << "Specify an owner person or group, not both"
    end
  end

  # Ensure a group does not attempt to own itself
  def group_cannot_own_itself
    if !group.blank? and group == owner_group
      errors[:base] << "Group cannot own itself"
    end
  end
end
