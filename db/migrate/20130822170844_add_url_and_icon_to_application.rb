class AddUrlAndIconToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :url, :string
    add_attachment :applications, :icon
  end
end
