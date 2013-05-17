class RenameFavoritePersonIdToEntityId < ActiveRecord::Migration
  def change
    rename_column :person_favorite_assignments, :person_id, :entity_id
  end
end
