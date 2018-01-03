class CreateTrackedItems < ActiveRecord::Migration[5.1]
  def change
    create_table :tracked_items do |t|
      t.string :kind
      t.integer :item_id

      t.timestamps
    end
  end
end
