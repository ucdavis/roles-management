class FixRecentRoleAssignmentMistakes < ActiveRecord::Migration
  def change
    drop_table :calculated_role_assignments
    rename_table :explicit_role_assignments, :role_assignments
    add_column :role_assignments, :calculated, :boolean, :default => false
  end
end
