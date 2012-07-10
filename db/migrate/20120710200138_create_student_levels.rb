class CreateStudentLevels < ActiveRecord::Migration
  def change
    create_table :student_levels do |t|
      t.string :name

      t.timestamps
    end
  end
end
