class AddOperatorGroupIdToGroupOperatorAssignments < ActiveRecord::Migration
  def change
    add_column :group_operator_assignments, :operator_group_id, :integer
  end
end
