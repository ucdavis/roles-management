class AddMajorIdToPerson < ActiveRecord::Migration
  def change
    add_column :people, :major_id, :integer
  end
end
