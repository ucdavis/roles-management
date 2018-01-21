class DropClassificationsAndClassificationsJoinTable < ActiveRecord::Migration[5.1]
  def change
    drop_table :classifications
    drop_table :classifications_titles
  end
end
