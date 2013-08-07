class DropOldApiUserTable < ActiveRecord::Migration
  def change
    drop_table :api_users
  end
end
