class AddLevelCodeAndAssocRankToSisAssociation < ActiveRecord::Migration[5.1]
  def change
    add_column :sis_associations, :level_code, :string, limit: 2
    add_column :sis_associations, :association_rank, :integer
  end
end
