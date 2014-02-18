class OrganizationParentIdParentOrgIdFieldShouldBeInteger < ActiveRecord::Migration
  class << self
    include AlterColumn
  end
  
  def self.up
    if ActiveRecord::Base.connection.instance_values["config"][:adapter] == "postgresql"
      # PostgreSQL does not allow us to simply cast a string to an integer even though all column data is compatible
      alter_column :organization_parent_ids, :parent_org_id, :integer, "USING CAST(parent_org_id AS integer)", 1
    else
      change_column :organization_parent_ids, :parent_org_id, :integer
    end
  end

  def self.down
    change_column :organization_parent_ids, :parent_org_id, :string
  end
end
