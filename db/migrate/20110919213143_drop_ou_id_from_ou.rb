class DropOuIdFromOu < ActiveRecord::Migration
  def up
    remove_column :ous, :ou_id
  end

  def down
    add_column :ous, :ou_id, :integer
  end
end
