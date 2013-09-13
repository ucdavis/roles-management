class AddParentIdToApplicationOwnership < ActiveRecord::Migration
  def change
    add_column :application_ownerships, :parent_id, :integer, :default => nil
  end
end
