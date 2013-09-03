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
