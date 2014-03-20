class CreateActivityLogTagAssociations < ActiveRecord::Migration
  def change
    create_table :activity_log_tag_associations do |t|
      t.integer :activity_log_id
      t.integer :activity_log_tag_id
    end
  end
end
