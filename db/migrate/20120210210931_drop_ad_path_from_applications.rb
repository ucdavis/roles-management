class DropAdPathFromApplications < ActiveRecord::Migration
  def change
    remove_column :applications, :ad_path
  end
end
