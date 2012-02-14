class AddCodeToTitles < ActiveRecord::Migration
  def change
    add_column :titles, :code, :string
  end
end
