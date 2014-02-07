class CreateOrganizationParentIds < ActiveRecord::Migration
  def change
    create_table :organization_parent_ids do |t|
      t.integer :organization_id
      t.string :parent_org_id

      t.timestamps
    end
  end
end
