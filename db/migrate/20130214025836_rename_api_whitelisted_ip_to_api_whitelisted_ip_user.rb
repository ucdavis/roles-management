class RenameApiWhitelistedIpToApiWhitelistedIpUser < ActiveRecord::Migration
  def change
    rename_table :api_whitelisted_ips, :api_whitelisted_ip_users
  end
end
