class UseUidNotUuidForDiary < ActiveRecord::Migration
  def change
    rename_column :diary_entries, :uuid_id, :uid_id
    rename_table :diary_entry_uuids, :diary_entry_uids
    rename_column :diary_entry_uids, :uuid_ref, :uid_ref
    rename_column :diary_entry_uids, :uuid_display_name, :display_name
  end
end
