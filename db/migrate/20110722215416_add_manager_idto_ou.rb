class AddManagerIdtoOu < ActiveRecord::Migration
  def self.up
    add_column :ous, :manager_id, :integer
  end

  def self.down
    remove_column :ous, :manager_id
  end
end
