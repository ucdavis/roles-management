class AddBargainingUnitToTitle < ActiveRecord::Migration[5.1]
  def change
    add_column :titles, :unit, :string, limit: 3
  end
end
