class CreateOuChildrenAssignments < ActiveRecord::Migration
  def up
    create_table :ou_children_assignments do |t|
      t.integer  :ou_id
      t.integer  :child_id
    end
  end

  def down
    drop_table :ou_children_assignments
  end
end
