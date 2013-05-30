class CreateGroupCalculatedMemberAssignments < ActiveRecord::Migration
  def change
    create_table :group_calculated_member_assignments do |t|
      t.integer :group_id
      t.integer :entity_id

      t.timestamps
    end
  end
end
