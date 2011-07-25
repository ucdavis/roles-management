class ChangeUrlToHostInApplication < ActiveRecord::Migration
  def self.up
    rename_column :applications, :url, :hostname
  end

  def self.down
    rename_column :applications, :hostname, :url
  end
end
