class RecreateAffiliationTable < ActiveRecord::Migration
  def up
    create_table :affiliations do |t|
      t.string name
    end
  end

  def down
    drop_table :affiliations
  end
end
