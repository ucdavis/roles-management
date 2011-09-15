class DropAffiliationIdFromPeople < ActiveRecord::Migration
  def up
    remove_column :people, :affiliation_id
  end

  def down
    add_column :people, :affiliation_id, :integer
  end
end
