class AddGrCodeToMajor < ActiveRecord::Migration[5.2]
  def change
    add_column :majors, :gr_code, :string, limit: 5, after: :name
  end
end
