class RenameGroupManagerAssignmentsToGroupOwnerAssignments < ActiveRecord::Migration
  def up
    rename_table :group_manager_assignments, :group_owner_assignments
  end

  def down
    rename_table :group_owner_assignments, :group_manager_assignments
  end
end
