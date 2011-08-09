class RenameOuTitleToOuName < ActiveRecord::Migration
  def self.up
    rename_column :ous, :title, :name
  end

  def self.down
    rename_column :ous, :name, :title
  end
end
