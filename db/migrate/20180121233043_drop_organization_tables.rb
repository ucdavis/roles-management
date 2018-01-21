class DropOrganizationTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :organization_entity_associations
    drop_table :organization_managers
    drop_table :organization_org_ids
    drop_table :organization_parent_ids
    drop_table :organizations
  end
end
