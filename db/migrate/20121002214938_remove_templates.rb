class RemoveTemplates < ActiveRecord::Migration
  def change
    drop_table :templates
    drop_table :template_rules
    drop_table :template_assignments
  end
end
