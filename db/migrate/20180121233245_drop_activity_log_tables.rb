class DropActivityLogTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :activity_log_tag_associations
    drop_table :activity_log_tags
    drop_table :activity_logs
  end
end
