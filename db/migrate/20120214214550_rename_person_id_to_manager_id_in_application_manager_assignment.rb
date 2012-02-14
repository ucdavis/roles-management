class RenamePersonIdToManagerIdInApplicationManagerAssignment < ActiveRecord::Migration
  def change
    rename_column :application_manager_assignments, :person_id, :manager_id
  end
end
