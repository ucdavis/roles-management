class CreateDiary < ActiveRecord::Migration
  def change
    create_table :diary_entries do |t|
      t.string :uuid_ref
      t.datetime :timestamp
      t.string :message
      t.integer :severity
    end

    add_index :diary_entries, :uuid_ref

    create_table :diary_entry_uuids do |t|
      t.string :uuid_ref
      t.string :uuid_display_name
    end

    add_index :diary_entry_uuids, :uuid_ref
  end
end
