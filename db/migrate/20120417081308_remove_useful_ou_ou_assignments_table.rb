class RemoveUsefulOuOuAssignmentsTable < ActiveRecord::Migration
  def up
    drop_table :ou_ou_assignments
  end

  def down
    puts "This migration is not reversible."
  end
end
