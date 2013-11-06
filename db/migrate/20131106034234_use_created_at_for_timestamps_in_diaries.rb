class UseCreatedAtForTimestampsInDiaries < ActiveRecord::Migration
  def change
    remove_column :diary_entries, :timestamp
    add_column :diary_entries, :created_at, :timestamp
  end
end
