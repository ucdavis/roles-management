class AddIndiciesToOrganizationTables < ActiveRecord::Migration
  def change
    add_index :organizations, :dept_code
    add_index :organization_parent_ids, :organization_id
    add_index :organization_parent_ids, :parent_org_id
    add_index :organization_org_ids, :organization_id
    add_index :organization_org_ids, :org_id
  end
end
