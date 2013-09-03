class AddParentIdToApplicationOperatorship < ActiveRecord::Migration
  def change
    add_column :application_operatorships, :parent_id, :integer, :default => nil
    add_index :application_operatorships, [:application_id, :entity_id, :parent_id], :name => 'idx_app_operatorships_on_app_id_and_entity_id_and_parent_id'
  end
end
