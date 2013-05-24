class RenameEntitiesGroupsToGroupMemberAssignments < ActiveRecord::Migration
  def change
    rename_table :entities_groups, :group_member_assignments
  end
end
