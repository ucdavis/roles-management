class CreateOrganizationManagers < ActiveRecord::Migration
  def change
    create_table :organization_managers do |t|
      t.integer :organization_id
      t.integer :manager_id

      t.timestamps
    end
  end
end
