class AddLevelToActivityLog < ActiveRecord::Migration
  def change
    add_column :activity_logs, :level, :integer
  end
end
