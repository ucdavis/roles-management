class RenameRoleAssignmentsToExplicitRoleAssignments < ActiveRecord::Migration
  def change
    rename_table :role_assignments, :explicit_role_assignments
  end
end
