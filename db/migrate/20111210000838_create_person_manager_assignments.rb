class CreatePersonManagerAssignments < ActiveRecord::Migration
  def change
    create_table :person_manager_assignments do |t|
      t.integer :person_id
      t.integer :manager_id
      t.timestamps
    end
  end
end
