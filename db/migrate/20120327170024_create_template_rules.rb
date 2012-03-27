class CreateTemplateRules < ActiveRecord::Migration
  def change
    create_table :template_rules do |t|
      t.string :condition
      t.string :column

      t.timestamps
    end
  end
end
