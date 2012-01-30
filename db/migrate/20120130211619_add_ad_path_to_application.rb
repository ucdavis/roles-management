class AddAdPathToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :ad_path, :string
  end
end
