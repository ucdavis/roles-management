class AddApiKeyIdtoApplication < ActiveRecord::Migration
  def change
    add_column :applications, :api_key_id, :integer
  end
end
