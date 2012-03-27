class RenameTemplateRuleColumnToValue < ActiveRecord::Migration
  def change
    rename_column :template_rules, :column, :value
  end
end
