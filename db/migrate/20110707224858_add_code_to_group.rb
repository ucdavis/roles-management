class AddCodeToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :code, :integer
  end

  def self.down
    remove_column :groups, :code
  end
end
