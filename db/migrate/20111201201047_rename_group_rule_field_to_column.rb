class RenameGroupRuleFieldToColumn < ActiveRecord::Migration
  def change
    rename_column :group_rules, :field, :column
  end
end
