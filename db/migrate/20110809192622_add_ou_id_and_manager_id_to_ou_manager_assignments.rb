class AddOuIdAndManagerIdToOuManagerAssignments < ActiveRecord::Migration
  def self.up
    add_column :ou_manager_assignments, :ou_id, :integer
    add_column :ou_manager_assignments, :manager_id, :integer
  end

  def self.down
    remove_column :ou_manager_assignments, :ou_id
    remove_column :ou_manager_assignments, :manager_id
  end
end
