class ChangeOuCodeFromIntegerToString < ActiveRecord::Migration
  def up
    change_column :ous, :code, :string
  end

  def down
    change_column :ous, :code, :integer
  end
end
