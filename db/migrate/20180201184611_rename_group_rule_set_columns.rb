class RenameGroupRuleSetColumns < ActiveRecord::Migration[5.1]
  def change
    rename_column :group_rule_results, :group_rule_set_id, :group_rule_result_set_id
    rename_column :group_rules, :group_rule_set_id, :group_rule_result_set_id
  end
end
