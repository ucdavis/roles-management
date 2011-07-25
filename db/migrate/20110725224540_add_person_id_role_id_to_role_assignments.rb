class AddPersonIdRoleIdToRoleAssignments < ActiveRecord::Migration
  def self.up
    add_column :role_assignments, :person_id, :integer
    add_column :role_assignments, :role_id, :integer
  end

  def self.down
    remove_column :role_assignments, :person_id
    remove_column :role_assignments, :role_id
  end
end
