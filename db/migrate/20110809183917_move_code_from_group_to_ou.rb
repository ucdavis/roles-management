class MoveCodeFromGroupToOu < ActiveRecord::Migration
  def self.up
    remove_column :groups, :code
    add_column :ous, :code, :integer
  end

  def self.down
    add_column :groups, :code, :integer
    remove_column :ous, :code
  end
end
