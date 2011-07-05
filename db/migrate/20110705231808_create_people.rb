class CreatePeople < ActiveRecord::Migration
  def self.up
    create_table :people do |t|
      t.string :first
      t.string :last
      t.string :email
      t.string :loginid
      t.string :preferred_name
      t.boolean :status
      t.integer :phone
      t.string :address

      t.timestamps
    end
  end

  def self.down
    drop_table :people
  end
end
