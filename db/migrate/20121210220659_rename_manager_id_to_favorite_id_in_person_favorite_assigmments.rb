class RenameManagerIdToFavoriteIdInPersonFavoriteAssigmments < ActiveRecord::Migration
  def change
    rename_column :person_favorite_assignments, :manager_id, :favorite_id
  end
end
