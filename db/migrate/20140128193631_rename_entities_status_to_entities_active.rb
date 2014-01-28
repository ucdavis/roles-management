class RenameEntitiesStatusToEntitiesActive < ActiveRecord::Migration
  def change
    rename_column :entities, :status, :active
  end
end
