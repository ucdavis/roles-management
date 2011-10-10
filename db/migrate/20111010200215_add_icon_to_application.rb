class AddIconToApplication < ActiveRecord::Migration
  def change
    add_column :applications, :icon_file_name,    :string
    add_column :applications, :icon_content_type, :string
    add_column :applications, :icon_file_size,    :integer
    add_column :applications, :icon_updated_at,   :datetime
  end
end
