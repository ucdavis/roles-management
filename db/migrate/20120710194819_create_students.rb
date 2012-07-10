class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.integer :student_level_id
      t.integer :person_id

      t.timestamps
    end
  end
end
