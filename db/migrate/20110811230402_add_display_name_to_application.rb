class AddDisplayNameToApplication < ActiveRecord::Migration
  def self.up
    add_column :applications, :display_name, :string
  end

  def self.down
    remove_column :applications, :display_name
  end
end
