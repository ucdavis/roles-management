class CreateOrganizationOrgIds < ActiveRecord::Migration
  def change
    create_table :organization_org_ids do |t|
      t.integer :organization_id
      t.string :org_id

      t.timestamps
    end
  end
end
