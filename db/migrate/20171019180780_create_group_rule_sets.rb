class CreateGroupRuleSets < ActiveRecord::Migration[5.1]
  def change
    # Create GroupRuleSet table
    create_table :group_rule_sets do |t|
      t.string :column
      t.boolean :condition
      t.string :value

      t.timestamps
    end

    # GroupRuleResults will belong to GroupRuleSet, not GroupRule
    rename_column :group_rule_results, :group_rule_id, :group_rule_set_id

    # GroupRules will belong to a GroupRuleSet
    add_column :group_rules, :group_rule_set_id, :integer
  end
end
