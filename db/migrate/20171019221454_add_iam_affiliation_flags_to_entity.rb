class AddIamAffiliationFlagsToEntity < ActiveRecord::Migration[5.1]
  def change
    add_column :entities, :is_employee, :boolean, default: nil
    add_column :entities, :is_hs_employee, :boolean, default: nil
    add_column :entities, :is_faculty, :boolean, default: nil
    add_column :entities, :is_student, :boolean, default: nil
    add_column :entities, :is_staff, :boolean, default: nil
    add_column :entities, :is_external, :boolean, default: nil
  end
end
