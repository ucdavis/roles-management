class DropMoreOuRelatedTables < ActiveRecord::Migration
  def up
    drop_table :application_ou_assignments
  end

  def down
    puts "This migration is not reversible."
  end
end
