class RenameGroupAssignmentsToGroupMemberAssignments < ActiveRecord::Migration
  def change
    rename_table :group_assignments, :group_member_assignments
  end
end
