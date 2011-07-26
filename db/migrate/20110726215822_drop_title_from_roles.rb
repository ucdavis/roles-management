class DropTitleFromRoles < ActiveRecord::Migration
  def self.up
    remove_column :roles, :title
  end

  def self.down
    add_column :roles, :title, :string
  end
end
