class DepartmentsDisplayNameIsNullable < ActiveRecord::Migration[5.2]
  def change
    change_column :departments, :displayName, :string, null: true
  end
end
