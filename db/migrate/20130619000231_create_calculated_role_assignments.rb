class CreateCalculatedRoleAssignments < ActiveRecord::Migration
  def change
    create_table :calculated_role_assignments do |t|
      t.integer :role_id
      t.integer :entity_id
    end
  end
end
