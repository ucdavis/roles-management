class CreateGroupChildrenAssignments < ActiveRecord::Migration
  def change
    create_table :group_children_assignments do |t|
      t.integer  :group_id
      t.integer  :child_id
    end
  end
end
