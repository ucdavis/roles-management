class AddManagerIdToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :manager_id, :integer
  end

  def self.down
    remove_column :groups, :manager_id
  end
end
