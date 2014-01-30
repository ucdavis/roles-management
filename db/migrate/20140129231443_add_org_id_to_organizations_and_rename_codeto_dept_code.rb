class AddOrgIdToOrganizationsAndRenameCodetoDeptCode < ActiveRecord::Migration
  def change
    rename_column :organizations, :code, :dept_code
    add_column :organizations, :org_id, :string
  end
end
