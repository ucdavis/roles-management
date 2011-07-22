class AddParentOuIdToOu < ActiveRecord::Migration
  def self.up
    add_column :ous, :ou_id, :integer
  end

  def self.down
    remove_column :ous, :ou_id
  end
end
