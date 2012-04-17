class RecreateClassificationsTitleTable < ActiveRecord::Migration
  def change
    create_table :classifications_titles do |t|
      t.integer :classification_id
      t.integer :title_id
    end
  end
end
