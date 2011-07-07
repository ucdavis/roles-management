class AddAffiliationIdToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :affiliation_id, :integer
  end

  def self.down
    add_column :people, :affiliation_id
  end
end
