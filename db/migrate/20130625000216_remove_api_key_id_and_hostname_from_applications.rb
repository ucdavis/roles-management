class RemoveApiKeyIdAndHostnameFromApplications < ActiveRecord::Migration
  def change
    remove_column :applications, :api_key_id
    remove_column :applications, :hostname
  end
end
