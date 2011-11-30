class CreateGroupRules < ActiveRecord::Migration
  def change
    create_table :group_rules do |t|
      t.string :field
      t.string :condition
      t.string :value

      t.timestamps
    end
  end
end
