class AddApplicationIdAndOuIdToApplicationOuAssignments < ActiveRecord::Migration
  def self.up
    add_column :application_ou_assignments, :application_id, :integer
    add_column :application_ou_assignments, :ou_id, :integer
  end

  def self.down
    remove_column :application_ou_assignments, :application_id
    remove_column :application_ou_assignments, :ou_id
  end
end
