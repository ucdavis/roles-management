class AddReasonToApiWhitelist < ActiveRecord::Migration
  def change
    add_column :api_whitelisted_ips, :reason, :text
  end
end
