class AddAdditionalDepartmentsToPpsAssociation < ActiveRecord::Migration[5.1]
  def change
    add_column :pps_associations, :admin_department_id, :integer
    add_column :pps_associations, :appt_department_id, :integer
  end
end
