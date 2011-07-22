class GroupTableSelfJoinTable < ActiveRecord::Migration
  def self.up
    create_table :group_group, :id => false do |t|
      t.integer :group_id
      t.integer :subgroup_id
    end
  end

  def self.down
    drop_table :group_group
  end
end
