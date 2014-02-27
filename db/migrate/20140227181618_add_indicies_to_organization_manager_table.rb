class AddIndiciesToOrganizationManagerTable < ActiveRecord::Migration
  def change
    add_index :organization_managers, :organization_id
    add_index :organization_managers, :manager_id
  end
end
