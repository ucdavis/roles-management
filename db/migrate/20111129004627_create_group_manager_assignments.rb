class CreateGroupManagerAssignments < ActiveRecord::Migration
  def change
    create_table :group_manager_assignments do |t|
      t.integer :group_id
      t.integer :manager_id
      t.timestamps
    end
  end
end
