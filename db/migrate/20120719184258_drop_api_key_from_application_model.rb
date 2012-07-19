class DropApiKeyFromApplicationModel < ActiveRecord::Migration
  def change
    remove_column :applications, :api_key
  end
end
