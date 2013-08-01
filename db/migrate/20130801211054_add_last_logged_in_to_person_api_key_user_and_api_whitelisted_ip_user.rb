class AddLastLoggedInToPersonApiKeyUserAndApiWhitelistedIpUser < ActiveRecord::Migration
  def change
    add_column :entities, :logged_in_at, :datetime
    add_column :api_key_users, :logged_in_at, :datetime
    add_column :api_whitelisted_ip_users, :logged_in_at, :datetime
  end
end
