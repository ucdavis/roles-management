class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :code
      t.integer :parent_organization_id

      t.timestamps
    end
  end
end
