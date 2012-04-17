class DropGroupGroupTable < ActiveRecord::Migration
  def up
    drop_table :group_group
  end

  def down
    puts "This migration is not reversible."
  end
end
