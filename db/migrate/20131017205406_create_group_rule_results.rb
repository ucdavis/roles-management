class CreateGroupRuleResults < ActiveRecord::Migration
  def change
    create_table :group_rule_results do |t|
      t.integer :group_rule_id
      t.integer :entity_id

      t.timestamps
    end
  end
end
