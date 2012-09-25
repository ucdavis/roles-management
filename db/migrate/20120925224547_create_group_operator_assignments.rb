class CreateGroupOperatorAssignments < ActiveRecord::Migration
  def change
    create_table :group_operator_assignments do |t|
      t.integer :group_id
      t.integer :operator_person_id

      t.timestamps
    end
  end
end
