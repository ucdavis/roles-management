class AddTitleToRole < ActiveRecord::Migration
  def self.up
    add_column :roles, :title, :string
  end

  def self.down
    add_column :roles, :title
  end
end
