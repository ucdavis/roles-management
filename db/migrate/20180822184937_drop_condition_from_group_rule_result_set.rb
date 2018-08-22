class DropConditionFromGroupRuleResultSet < ActiveRecord::Migration[5.2]
  def change
    # Merge any GroupRuleResultSets that are now non-unique due to dropping the
    # 'condition' column
    GroupRuleResultSet.all.group_by { |s| [s.column, s.value] }.each do |column, value|
      if value.length > 1
        raise 'Unexpected database conditions' if value.length > 2
        # Need to merge these GroupRuleResultSets
        keep_set = value[0]
        delete_set = value[1]
        if keep_set.condition == 0
          keep_set = value[1]
          delete_set = value[0]
        end
        raise 'Unexpected database conditions' if keep_set.condition == 0

        delete_set.rules.each do |rule|
          rule.result_set = keep_set
          rule.save!
        end

        delete_set.destroy
      end
    end

    # Drop the 'condition' column
    remove_column :group_rule_result_sets, :condition
  end
end
