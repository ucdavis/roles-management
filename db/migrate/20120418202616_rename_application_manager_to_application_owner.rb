class RenameApplicationManagerToApplicationOwner < ActiveRecord::Migration
  def change
    rename_column :application_manager_assignments, :manager_id, :owner_id
    rename_table :application_manager_assignments, :application_owner_assignments
  end
end
