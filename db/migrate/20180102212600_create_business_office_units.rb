class CreateBusinessOfficeUnits < ActiveRecord::Migration[5.1]
  def change
    create_table :business_office_units do |t|
      t.string :org_oid
      t.string :dept_code
      t.string :dept_official_name
      t.string :dept_display_name
      t.string :dept_abbrev
      t.boolean :is_ucdhs

      t.timestamps
    end
  end
end
