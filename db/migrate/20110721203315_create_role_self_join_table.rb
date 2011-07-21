class CreateRoleSelfJoinTable < ActiveRecord::Migration
  def self.up
    create_table :roles_roles do |t|
          t.integer :role_id
          t.integer :subrole_id
        end
  end

  def self.down
    drop_table :roles_roles
  end
end
