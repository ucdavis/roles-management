class AddGroupIdToGroupRules < ActiveRecord::Migration
  def change
    add_column :group_rules, :group_id, :integer
  end
end
