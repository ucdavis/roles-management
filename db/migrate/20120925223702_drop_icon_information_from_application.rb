class DropIconInformationFromApplication < ActiveRecord::Migration
  def change
    remove_column :applications, :icon_file_name
    remove_column :applications, :icon_content_type
    remove_column :applications, :icon_file_size
    remove_column :applications, :icon_updated_at
  end
end
