class RecalculateRoleAssignmentsAfter20130903Migration < ActiveRecord::Migration
  def up
    Authorization.ignore_access_control(true)
    
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

  def down
    puts "This migration is not reversible."
  end
end
