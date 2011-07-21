class AddBelongsToRoleForGroupsAndPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :role_id, :integer
    add_column :groups, :role_id, :integer
  end

  def self.down
    remove_column :people, :role_id
    remove_column :groups, :role_id
  end
end
