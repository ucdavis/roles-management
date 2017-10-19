class DropPersonMajorColumn < ActiveRecord::Migration[5.1]
  def change
    remove_column :entities, :major_id
  end
end
