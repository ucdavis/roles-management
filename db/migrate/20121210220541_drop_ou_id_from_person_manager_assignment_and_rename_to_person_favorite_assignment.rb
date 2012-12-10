class DropOuIdFromPersonManagerAssignmentAndRenameToPersonFavoriteAssignment < ActiveRecord::Migration
  def change
    remove_column :person_manager_assignments, :ou_id

    rename_table :person_manager_assignments, :person_favorite_assignments
  end
end
