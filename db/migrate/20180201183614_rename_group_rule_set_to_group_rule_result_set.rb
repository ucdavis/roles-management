class RenameGroupRuleSetToGroupRuleResultSet < ActiveRecord::Migration[5.1]
  def change
    rename_table :group_rule_sets, :group_rule_result_sets
  end
end
