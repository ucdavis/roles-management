# We need a copy of the old RoleAssignment class for this migration to work
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
          ra.calculated = true
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
          ra = RoleAssignment.find_by_role_id_and_entity_id_and_calculated(role.id, m.id, true)
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
  
  def cannot_destroy_calculated_assignment_without_flag
    if calculated and not @@destroy_calculated_assignment_flag
      errors.add(:calculated, "can't destroy a calculated role assignment without flag properly set")
      return false
    end
  end
end

class ReplaceRoleCalculatedColumnWithParentId < ActiveRecord::Migration
  def change
    Authorization.ignore_access_control(true)
    
    # Remove old calculated role assignments (will be recalculated)
    RoleAssignment.where(:calculated => true).each do |ra|
      destroying_calculated_role_assignment do
        ra.destroy
      end
    end
    
    remove_index :role_assignments, [:role_id, :entity_id, :calculated]
    remove_column :role_assignments, :calculated
    add_column :role_assignments, :parent_id, :integer, :default => nil
    add_index :role_assignments, [:role_id, :entity_id, :parent_id]
    
    # Reload model information given the above column changes
    RoleAssignment.connection.schema_cache.clear!
    RoleAssignment.reset_column_information
    
    # Recalculate role assignments
    RoleAssignment.all.each do |ra|
      if ra.entity.type == 'Group'
        Rails.logger.tagged "RoleAssignment #{ra.id}" do
          ra.entity.members.each do |m|
            Rails.logger.info "Granting role (#{ra.role.id}, #{ra.role.token}, #{ra.role.application.name}) just granted to group (#{ra.entity.id}/#{ra.entity.name}) to its member (#{m.id}/#{m.name})"
            ra_new = RoleAssignment.new
            ra_new.role_id = ra.role.id
            ra_new.entity_id = m.id
            ra_new.parent_id = ra.entity.id
            if ra_new.save == false
              Rails.logger.error "  -- Could not grant role!"
            end
          end
        end
      end
    end
    
    Authorization.ignore_access_control(false)
  end
end
