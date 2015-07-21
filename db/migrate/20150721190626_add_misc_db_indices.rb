class AddMiscDbIndices < ActiveRecord::Migration
  def change
    add_index :entities, :id
    add_index :entities, :type
    add_index :roles, :id
  end
end
