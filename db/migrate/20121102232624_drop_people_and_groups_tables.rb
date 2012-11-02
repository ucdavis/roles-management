class DropPeopleAndGroupsTables < ActiveRecord::Migration
  def up
    drop_table :people
    drop_table :groups
  end

  def down
    puts "This migration is not reversible."
  end
end
