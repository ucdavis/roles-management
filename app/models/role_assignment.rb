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
  validates_uniqueness_of :role_id, :scope => [:entity_id, :parent_id]
  validate :assignment_cannot_be_cyclical # must come before the possibly cyclical operations of granting role assignments in after_create
  before_destroy :cannot_destroy_calculated_assignment_without_flag
  
  # Though this seems like 'group' logic, it must be done in this 'join table' class
  # as role assignments can be created by e.g. saving an application with roles_attributes
  # and modifying a role's entity_ids, meaning these callbacks would work but
  # the Group being assigned would never have its callbacks used
  after_create :grant_role_assignments_to_group_members_if_needed
  before_destroy :remove_role_assignments_from_group_members_if_needed
  
  private

  # Grant this role assignment to all members of the group
  # (only if this role assignment really is with a group)
  def grant_role_assignments_to_group_members_if_needed
    if entity.type == 'Group'
      Rails.logger.tagged "RoleAssignment #{id}" do
        entity.members.each do |m|
          logger.info "Granting role (#{role.id}, #{role.token}, #{role.application.name}) just granted to group (#{entity.id}/#{entity.name}) to its member (#{m.id}/#{m.name})"
          ra = RoleAssignment.new
          ra.role_id = role.id
          ra.entity_id = m.id
          ra.parent_id = entity.id
          if ra.save == false
            logger.error "  -- Could not grant role!"
          end
        end
      end
    end
  end

  # Remove this role assignment from all members of the group
  # (only if this role assignment really was with a group)  
  def remove_role_assignments_from_group_members_if_needed
    if entity.type == 'Group'
      Rails.logger.tagged "RoleAssignment #{id}" do
        entity.members.each do |m|
          logger.info "Removing role (#{role.id}, #{role.token}, #{role.application.name}) about to be removed from group (#{entity.id}/#{entity.name} from its member #{m.id}/#{m.name})"
          ra = RoleAssignment.find_by_role_id_and_entity_id_and_parent_id(role.id, m.id, entity.id)
          if ra
            destroying_calculated_role_assignment do
              ra.destroy
            end
          else
            logger.warn "Failed to remove role (#{role.id}, #{role.token}, #{role.application.name}) assigned to group member (#{m.id}/#{m.name}) which needs to be removed as the group (#{entity.id}/#{entity.name}) is losing that role. This is probably okay."
          end
        end
      end
    end
  end
  
  def assignment_cannot_be_cyclical
    
  end
  
  def cannot_destroy_calculated_assignment_without_flag
    if not @@destroy_calculated_assignment_flag
      errors.add(:parent_id, "can't destroy a calculated role assignment without flag properly set")
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
