class CreateOuAssignments < ActiveRecord::Migration
  def self.up
    create_table :ou_assignments do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :ou_assignments
  end
end
