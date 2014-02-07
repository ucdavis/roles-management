class DropOrganizationParentId < ActiveRecord::Migration
  def change
    remove_column :organizations, :parent_organization_id
  end
end
