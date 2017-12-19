class CreateDepartments < ActiveRecord::Migration[5.1]
  def change
    create_table :departments do |t|
      t.string :code, null: false
      t.string :officialName, null: false
      t.string :displayName, null: false
      t.string :abbreviation, null: false

      t.timestamps
    end
  end
end
