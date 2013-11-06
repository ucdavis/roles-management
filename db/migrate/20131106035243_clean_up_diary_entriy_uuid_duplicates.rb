class CleanUpDiaryEntriyUuidDuplicates < ActiveRecord::Migration
  def change
    remove_column :diary_entries, :diary_entry_uuid_id
    rename_column :diary_entries, :uuid_ref_id, :uuid_id
  end
end
