class OrganizationParentIdParentOrgIdFieldShouldBeInteger < ActiveRecord::Migration
  def up
    change_column :organization_parent_ids, :parent_org_id, :integer
  end

  def down
    change_column :organization_parent_ids, :parent_org_id, :string
  end
end
