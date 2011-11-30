class RenameTitleTitleToTitleName < ActiveRecord::Migration
  def change
    rename_column :titles, :title, :name
  end
end
