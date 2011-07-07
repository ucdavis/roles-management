class AddTitleIdToPerson < ActiveRecord::Migration
  def self.up
    add_column :people, :title_id, :integer
  end

  def self.down
    remove_column :people, :title_id
  end
end
