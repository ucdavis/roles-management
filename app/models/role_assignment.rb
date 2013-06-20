class RoleAssignment < ActiveRecord::Base
  using_access_control
  @@destroy_calculated_assignment_flag = false
  
  def self.destroy_calculated_assignment_flag=(val)
    @@destroy_calculated_assignment_flag = val
  end

  belongs_to :role
  belongs_to :entity
  validates :role_id, :entity_id, :presence => true
  before_destroy :cannot_destroy_calculated_assignment_without_flag
  
  private
  
  def cannot_destroy_calculated_assignment_without_flag
    unless defined? @@destroy_calculated_assignment_flag
      errors.add(:calculated, "can't destroy a calculated role assignment without flag")
      return false
    end
    
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
