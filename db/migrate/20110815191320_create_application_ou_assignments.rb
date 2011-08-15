class CreateApplicationOuAssignments < ActiveRecord::Migration
  def self.up
    create_table :application_ou_assignments do |t|

      t.timestamps
    end
  end

  def self.down
    drop_table :application_ou_assignments
  end
end
