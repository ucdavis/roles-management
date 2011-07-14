class AddMinAndMaxSizeToGroups < ActiveRecord::Migration
  def self.up
    add_column :groups, :min_size, :integer, :default => nil
    add_column :groups, :max_size, :integer, :default => nil
  end

  def self.down
    add_column :groups, :min_size
    add_column :groups, :max_size
  end
end
