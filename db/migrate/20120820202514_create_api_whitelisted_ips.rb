class CreateApiWhitelistedIps < ActiveRecord::Migration
  def change
    create_table :api_whitelisted_ips do |t|
      t.string :address

      t.timestamps
    end
  end
end
