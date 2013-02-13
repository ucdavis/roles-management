class AddApiKeyNameToApiKeys < ActiveRecord::Migration
  def change
    add_column :api_keys, :name, :string
  end
end
