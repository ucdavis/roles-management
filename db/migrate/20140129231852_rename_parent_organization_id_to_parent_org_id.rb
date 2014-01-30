class RenameParentOrganizationIdToParentOrgId < ActiveRecord::Migration
  def change
    rename_column :organizations, :parent_organization_id, :parent_org_id
  end
end
