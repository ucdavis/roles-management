class RenameAssignableToAssignment < ActiveRecord::Migration
  def self.up
    rename_table :assignables, :assignments
  end

  def self.down
    rename_table :assignments, :assignables
  end
end
