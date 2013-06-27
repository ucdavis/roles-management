# RoleAssignment may be calculated, in which case they need to be destroyed only by the proper method,
# e.g. through a group. A group accomplishes this by using the destroying_calculated_role_assignment do ... end
# block method below.
class RoleAssignment < ActiveRecord::Base
  using_access_control
  
  @@destroy_calculated_assignment_flag = false
  
  def self.destroy_calculated_assignment_flag=(val)
    @@destroy_calculated_assignment_flag = val
  end

  belongs_to :role
  belongs_to :entity
  validates :role_id, :entity_id, :presence => true
  validates_uniqueness_of :role_id, :scope => [:entity_id, :calculated]
  validate :assignment_cannot_be_cyclical
  before_destroy :cannot_destroy_calculated_assignment_without_flag
  
  # Though this seems like 'group' logic, it must be done in this 'join table' class
  # as role assignments can be created by e.g. saving an application with roles_attributes
  # and modifying a role's entity_ids, meaning these callbacks would work but
  # the Group being assigned would never have its callbacks used
  after_create :grant_role_assignments_to_group_members_if_needed
  before_destroy :remove_role_assignments_from_group_members_if_needed
  
  private
  
  def cannot_destroy_calculated_assignment_without_flag
    if calculated and not @@destroy_calculated_assignment_flag
      errors.add(:calculated, "can't destroy a calculated role assignment without flag properly set")
      return false
    end
  end
end

def destroying_calculated_role_assignment
  begin
    RoleAssignment.destroy_calculated_assignment_flag = true
    yield
  ensure
    RoleAssignment.destroy_calculated_assignment_flag = false
  end
end
