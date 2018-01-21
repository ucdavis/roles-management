class MigrateToGroupRuleSets < ActiveRecord::Migration[5.1]
  def change
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
