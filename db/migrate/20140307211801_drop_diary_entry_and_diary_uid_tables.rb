class DropDiaryEntryAndDiaryUidTables < ActiveRecord::Migration
  def up
    drop_table :diary_entries
    drop_table :diary_uids
  end

  def down
    puts "This migration is not reversible."
  end
end
