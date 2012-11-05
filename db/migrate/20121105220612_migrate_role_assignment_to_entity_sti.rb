class MigrateRoleAssignmentToEntitySti < ActiveRecord::Migration
  def up
    add_column :role_assignments, :entity_id, :integer

    Authorization.ignore_access_control(true)

    RoleAssignment.all.each do |ra|
      unless ra.person_id.nil?
        # Person-based role assignment
        ra.entity_id = ra.person_id
      else
        # Group-based role assignment
        ra.entity_id = ra.group_id
      end

      ra.save
    end

    Authorization.ignore_access_control(false)

    remove_column :role_assignments, :person_id
    remove_column :role_assignments, :group_id
  end

  def down
    puts "This migration is not reversible."
  end
end
