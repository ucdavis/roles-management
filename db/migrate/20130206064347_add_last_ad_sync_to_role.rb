class AddLastAdSyncToRole < ActiveRecord::Migration
  def change
    add_column :roles, :last_ad_sync, :datetime, :default => nil
  end
end
