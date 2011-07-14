class AddHeadToGroup < ActiveRecord::Migration
  def self.up
    add_column :groups, :head_id, :integer
  end

  def self.down
    remove_column :groups, :head_id
  end
end
