class RenameOwnerIdToEntityIdInApplicationOwnership < ActiveRecord::Migration
  def change
    rename_column :application_ownerships, :owner_id, :entity_id
  end
end
