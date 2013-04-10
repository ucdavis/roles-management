class FixColumnNamesInPersonFavoriteAssignments < ActiveRecord::Migration
  def change
    rename_column :person_favorite_assignments, :favorite_id, :owner_id
  end
end
