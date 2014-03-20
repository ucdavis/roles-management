class CreateActivityLogs < ActiveRecord::Migration
  def change
    create_table :activity_logs do |t|
      t.string :message
      t.datetime :performed_at
    end
  end
end
