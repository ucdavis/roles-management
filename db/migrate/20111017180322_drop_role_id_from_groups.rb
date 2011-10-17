class DropRoleIdFromGroups < ActiveRecord::Migration
  def up
    remove_column :groups, :role_id
  end

  def down
    add_column :groups, :role_id, :integer
  end
end
