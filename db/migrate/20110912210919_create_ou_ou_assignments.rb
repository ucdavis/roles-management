class CreateOuOuAssignments < ActiveRecord::Migration
  def change
    create_table :ou_ou_assignments do |t|

      t.timestamps
    end
  end
end
