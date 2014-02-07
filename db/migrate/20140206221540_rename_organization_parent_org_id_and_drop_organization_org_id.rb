class RenameOrganizationParentOrgIdAndDropOrganizationOrgId < ActiveRecord::Migration
  def change
    rename_column :organizations, :parent_org_id, :parent_organization_id
    remove_column :organizations, :org_id
  end
end
