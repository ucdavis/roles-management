class RenameNameToTokenAndAddShortDescriptorToRoles < ActiveRecord::Migration
  def change
    rename_column :roles, :name, :token
    add_column :roles, :descriptor, :string
  end
end
