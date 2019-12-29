class AddEmplClassToPpsAssociation < ActiveRecord::Migration[5.2]
  def change
    add_column :pps_associations, :employee_class, :integer
  end
end
