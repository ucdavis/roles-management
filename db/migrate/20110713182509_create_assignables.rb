class CreateAssignables < ActiveRecord::Migration
  def self.up
    create_table :assignables do |t|

      t.timestamps
      
      t.integer :assignment_id
    end
  end

  def self.down
    drop_table :assignables
  end
end
