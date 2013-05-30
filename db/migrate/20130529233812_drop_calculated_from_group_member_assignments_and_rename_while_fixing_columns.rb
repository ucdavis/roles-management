class DropCalculatedFromGroupMemberAssignmentsAndRenameWhileFixingColumns < ActiveRecord::Migration
  def change
    remove_column :group_member_assignments, :calculated
    add_column :group_member_assignments, :id, :primary_key
    rename_table :group_member_assignments, :group_explicit_member_assignments
  end
end
