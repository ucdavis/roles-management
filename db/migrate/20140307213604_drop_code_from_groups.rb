class DropCodeFromGroups < ActiveRecord::Migration
  def up
    remove_column :entities, :code
  end

  def down
    puts "This migration is not reversible."
  end
end
