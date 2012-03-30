class RenamePersonManagerAssignmentPersonBackToSubordinate < ActiveRecord::Migration
  def change
    rename_column :person_manager_assignments, :subordinate_id, :person_id
  end
end
