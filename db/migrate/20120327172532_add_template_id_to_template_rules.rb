class AddTemplateIdToTemplateRules < ActiveRecord::Migration
  def change
    add_column :template_rules, :template_id, :integer
  end
end
