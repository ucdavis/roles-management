class AddAdPathToPermissions < ActiveRecord::Migration
  def change
    add_column :roles, :ad_path, :string
  end
end
