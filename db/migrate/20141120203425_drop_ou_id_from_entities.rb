class DropOuIdFromEntities < ActiveRecord::Migration
  def change
    remove_column :entities, :ou_id
  end
end
