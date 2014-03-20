class CreateActivityLogTags < ActiveRecord::Migration
  def change
    create_table :activity_log_tags do |t|
      t.string :tag

      t.timestamps
    end
  end
end
