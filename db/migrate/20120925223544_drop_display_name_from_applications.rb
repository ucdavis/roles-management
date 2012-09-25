class DropDisplayNameFromApplications < ActiveRecord::Migration
  def change
    remove_column :applications, :display_name
  end
end
