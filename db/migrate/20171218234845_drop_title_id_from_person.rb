class DropTitleIdFromPerson < ActiveRecord::Migration[5.1]
  def change
    remove_column :entities, :title_id
  end
end
