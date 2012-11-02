class CreateEntitiesTable < ActiveRecord::Migration
  def up
    create_table :entities do |t|
      # Shared properties
      t.string :type
      t.string :name

      # Person properties
      t.string :first
      t.string :last
      t.string :email
      t.string :loginid
      t.boolean :status
      t.string :phone
      t.string :address
      t.integer :title_id
      t.integer :major_id

      # Group properties
      t.string :code
      t.text :description

      t.timestamps
    end
  end

  def down
    drop_table :entities
  end
end
