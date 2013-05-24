class AddCalculatedFlagToEntitiesGroups < ActiveRecord::Migration
  def change
    add_column :entities_groups, :calculated, :boolean, :default => false
  end
end
