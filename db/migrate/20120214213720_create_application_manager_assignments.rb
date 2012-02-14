class CreateApplicationManagerAssignments < ActiveRecord::Migration
  def change
    create_table :application_manager_assignments do |t|
      t.integer :person_id
      t.integer :application_id

      t.timestamps
    end
  end
end
