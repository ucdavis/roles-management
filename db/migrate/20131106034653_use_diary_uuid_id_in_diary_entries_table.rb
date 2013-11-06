class UseDiaryUuidIdInDiaryEntriesTable < ActiveRecord::Migration
  def change
    remove_column :diary_entries, :uuid_ref
    add_column :diary_entries, :uuid_ref_id, :integer
  end
end
