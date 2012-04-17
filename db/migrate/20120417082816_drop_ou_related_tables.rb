class DropOuRelatedTables < ActiveRecord::Migration
  def up
    drop_table :ous
    drop_table :ou_assignments
    drop_table :ou_children_assignments
    drop_table :ou_manager_assignments
  end

  def down
    puts "This migration is not reversible."
  end
end
