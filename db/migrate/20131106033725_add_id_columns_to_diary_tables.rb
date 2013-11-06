class AddIdColumnsToDiaryTables < ActiveRecord::Migration
  def change
    add_column :diary_entries, :id, :primary_key
    add_column :diary_entry_uuids, :id, :primary_key
    add_column :diary_entries, :diary_entry_uuid_id, :integer
  end
end
