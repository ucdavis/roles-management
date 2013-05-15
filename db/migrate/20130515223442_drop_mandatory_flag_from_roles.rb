class DropMandatoryFlagFromRoles < ActiveRecord::Migration
  def change
    remove_column :roles, :mandatory
  end
end
