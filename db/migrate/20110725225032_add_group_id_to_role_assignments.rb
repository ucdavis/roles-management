class AddGroupIdToRoleAssignments < ActiveRecord::Migration
  def self.up
    add_column :role_assignments, :group_id, :integer
  end

  def self.down
    remove_column :role_assignments, :group_id
  end
end
