class DropManagerIdFromOus < ActiveRecord::Migration
  def up
    remove_column :ous, :manager_id
  end

  def down
    add_column :ous, :manager_id, :integer
  end
end
