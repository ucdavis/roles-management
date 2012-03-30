class RenamePersonManagerAssignmentSubordinateToPerson < ActiveRecord::Migration
  def change
    rename_column :person_manager_assignments, :person_id, :subordinate_id
  end
end
