class RenameGroupOwnerAssignmentManagerIdToGroupOwnerAssignmentOwnerId < ActiveRecord::Migration
  def up
    rename_column :group_owner_assignments, :manager_id, :owner_id
  end

  def down
    rename_column :group_owner_assignments, :owner_id, :manager_id
  end
end
