class RenameApiKeyToApiKeyUser < ActiveRecord::Migration
  def change
    rename_table :api_keys, :api_key_users
  end
end
