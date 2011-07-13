class AddAssignableToAssignments < ActiveRecord::Migration
  def self.up
    add_column :assignments, :assignable_id, :integer
    add_column :assignments, :assignable_type, :string
  end

  def self.down
    remove_column :assignments, :assignable_id
    remove_column :assignments, :assignable_type
  end
end
