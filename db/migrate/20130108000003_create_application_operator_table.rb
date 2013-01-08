class CreateApplicationOperatorTable < ActiveRecord::Migration
  def change
    create_table :application_operator_assignments do |t|
      t.integer :application_id
      t.integer :entity_id

      t.timestamps
    end
  end
end
