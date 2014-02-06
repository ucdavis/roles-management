class ParentOrgIdShouldBeVarcharInOrganizations < ActiveRecord::Migration
  def up
    change_column :organizations, :parent_org_id, :string
  end

  def down
    change_column :organizations, :parent_org_id, :integer
  end
end
