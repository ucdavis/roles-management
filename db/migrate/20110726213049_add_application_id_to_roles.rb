class AddApplicationIdToRoles < ActiveRecord::Migration
  def self.up
    add_column :roles, :application_id, :integer
  end

  def self.down
    remove_column :roles, :application_id
  end
end
