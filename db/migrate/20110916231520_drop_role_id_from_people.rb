class DropRoleIdFromPeople < ActiveRecord::Migration
  def up
    remove_column :people, :role_id
  end

  def down
    add_column :people, :role_id, :integer
  end
end
