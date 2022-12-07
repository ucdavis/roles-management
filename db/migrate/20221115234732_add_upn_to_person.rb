class AddUpnToPerson < ActiveRecord::Migration[5.2]
  def change
    add_column :entities, :upn, :string, after: :loginid
  end
end
