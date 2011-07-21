class RemovePrimaryIdOnRolesRoles < ActiveRecord::Migration
  def self.up
    remove_column :roles_roles, :id
  end

  def self.down
    # No reason to go back
  end
end
