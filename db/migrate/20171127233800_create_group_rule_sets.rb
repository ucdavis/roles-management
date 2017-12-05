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

    # Destroy all previous GroupRuleResults. They will be re-calculated.
    GroupRuleResult.destroy_all

    # Copy all GroupRule data to GroupRuleSet, avoiding duplicates.
    GroupRule.all.each do |gr|
      gr.result_set = GroupRuleSet.find_or_create_by(
        column: gr.column,
        condition: gr.condition == 'is',
        value: gr.value
      )

      gr.save!
    end
  end
end
