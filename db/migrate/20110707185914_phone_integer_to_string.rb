class PhoneIntegerToString < ActiveRecord::Migration
  def self.up
    change_column :people, :phone, :string
  end

  def self.down
    change_column :people, :phone, :integer
  end
end
