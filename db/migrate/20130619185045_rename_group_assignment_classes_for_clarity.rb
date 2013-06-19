class RenameGroupAssignmentClassesForClarity < ActiveRecord::Migration
  def change
    rename_table :group_member_assignments, :group_memberships
    rename_table :group_operator_assignments, :group_operatorships
    rename_table :group_owner_assignments, :group_ownerships
  end
end
