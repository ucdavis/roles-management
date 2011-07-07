class AddCodeToTitle < ActiveRecord::Migration
  def self.up
    add_column :titles, :code, :integer
  end

  def self.down
    remove_column :titles, :code
  end
end
