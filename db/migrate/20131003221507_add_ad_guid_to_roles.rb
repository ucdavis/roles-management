class AddAdGuidToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :ad_guid, :string, :default => nil
  end
end
