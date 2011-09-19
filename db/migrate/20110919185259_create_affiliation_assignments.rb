class CreateAffiliationAssignments < ActiveRecord::Migration
  def change
    create_table :affiliation_assignments do |t|
      t.integer "affiliation_id"
      t.integer "person_id"
      
      t.timestamps
    end
  end
end
