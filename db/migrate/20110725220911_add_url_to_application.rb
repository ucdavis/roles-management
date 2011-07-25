class AddUrlToApplication < ActiveRecord::Migration
  def self.up
    add_column :applications, :url, :string
  end

  def self.down
    remove_column :applications, :url
  end
end
