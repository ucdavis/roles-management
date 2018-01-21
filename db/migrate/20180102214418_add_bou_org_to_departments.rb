class AddBouOrgToDepartments < ActiveRecord::Migration[5.1]
  def change
    add_column :departments, :bou_org_oid, :string
  end
end
