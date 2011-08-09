class CreateOuAssignmentTable < ActiveRecord::Migration
  def self.up
    add_column :ou_assignments, :person_id, :integer
    add_column :ou_assignments, :ou_id, :integer
  end

  def self.down
    remove_column :ou_assignments, :person_id
    remove_column :ou_assignments, :ou_id
  end
end
