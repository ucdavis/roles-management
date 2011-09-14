class DropRoleRoleSelfJoinTable < ActiveRecord::Migration
  def up
    drop_table :roles_roles
  end

  def down
    create_table :roles_roles do |t|
      t.integer :role_id
      t.integer :subrole_id
    end
  end
end
