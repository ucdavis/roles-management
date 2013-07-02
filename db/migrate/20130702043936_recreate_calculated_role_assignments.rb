class RecreateCalculatedRoleAssignments < ActiveRecord::Migration
  def up
    Authorization.ignore_access_control(true)
    
    # Simply recreate all uncalculated role assignments, relying on
    # add/remove callbacks to properly recreate the database.
    RoleAssignment.where(:calculated => false).each do |ra|
      role_id = ra.role_id
      entity_id = ra.entity_id
      
      ra.destroy
      
      new_ra = RoleAssignment.new
      new_ra.role_id = role_id
      new_ra.entity_id = entity_id
      new_ra.calculated = false
      new_ra.save
    end
    
    Authorization.ignore_access_control(false)
  end

  def down
    puts "This migration is not reversible. It creates new calculated role assignments."
  end
end
