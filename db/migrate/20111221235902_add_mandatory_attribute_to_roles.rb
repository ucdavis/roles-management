class AddMandatoryAttributeToRoles < ActiveRecord::Migration
  def change
    add_column :roles, :mandatory, :boolean
  end
end
