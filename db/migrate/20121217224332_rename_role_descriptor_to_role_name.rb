class RenameRoleDescriptorToRoleName < ActiveRecord::Migration
  def change
    rename_column :roles, :descriptor, :name
  end
end
