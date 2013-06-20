# GroupMembership may be calculated, in which case they need to be destroyed only by the proper method,
# e.g. through a group and not a person. A group accomplishes this by using the destroying_calculated_group_membership do ... end
# block method below.
class GroupMembership < ActiveRecord::Base
  using_access_control
  @@destroy_calculated_membership_flag = false
  
  def self.destroy_calculated_membership_flag=(val)
    @@destroy_calculated_membership_flag = val
  end

  validates_presence_of :group, :entity
  validate :group_cannot_join_itself
  before_destroy :cannot_destroy_calculated_membership_without_flag

  belongs_to :group
  belongs_to :entity

  private

  # Ensure a group does not attempt to join (member) itself
  def group_cannot_join_itself
    if !group.blank? and group == entity
      errors[:base] << "Group cannot join with itself"
    end
  end
  
  def cannot_destroy_calculated_membership_without_flag
    if calculated and not @@destroy_calculated_membership_flag
      errors.add(:calculated, "can't destroy a calculated group membership without flag properly set")
      return false
    end
  end
end

def destroying_calculated_group_membership
  begin
    GroupMembership.destroy_calculated_membership_flag = true
    yield
  ensure
    GroupMembership.destroy_calculated_membership_flag = false
  end
end
