class AddCodeToMajor < ActiveRecord::Migration[5.2]
  def change
    add_column :majors, :code, :string, limit: 5, after: :name
  end
end
