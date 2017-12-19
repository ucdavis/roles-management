class CreatePpsAssociations < ActiveRecord::Migration[5.1]
  def change
    create_table :pps_associations do |t|
      t.integer :person_id, null: false
      t.integer :title_id, null: false
      t.integer :department_id, null: false
      t.integer :association_rank, null: false
      t.integer :position_type_code, null: false

      t.timestamps
    end
  end
end
