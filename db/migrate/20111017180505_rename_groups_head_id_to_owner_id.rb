class RenameGroupsHeadIdToOwnerId < ActiveRecord::Migration
  def up
    rename_column :groups, :head_id, :owner_id
  end

  def down
    rename_column :groups, :owner_id, :head_id
  end
end
