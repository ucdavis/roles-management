class RemoveManagerIdFromGroups < ActiveRecord::Migration
  def self.up
    remove_column :groups, :manager_id
  end

  def self.down
    add_column :groups, :manager_id, :integer
  end
end
