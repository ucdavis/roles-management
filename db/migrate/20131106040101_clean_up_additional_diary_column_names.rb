class CleanUpAdditionalDiaryColumnNames < ActiveRecord::Migration
  def change
    rename_table :diary_entry_uids, :diary_uids
    rename_column :diary_uids, :uid_ref, :reference
    rename_column :diary_entries, :uid_id, :diary_uid_id
  end
end
