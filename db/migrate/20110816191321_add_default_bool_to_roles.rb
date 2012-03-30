class AddDefaultBoolToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :default, :integer, :default => 0
  end

  def self.down
    remove_column :roles, :default
  end
end
