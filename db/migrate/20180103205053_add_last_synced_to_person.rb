class AddLastSyncedToPerson < ActiveRecord::Migration[5.1]
  def change
    add_column :entities, :synced_at, :datetime
  end
end
