class DropStudentAndStudentLevelTables < ActiveRecord::Migration[5.1]
  def change
    drop_table :students
    drop_table :student_levels
  end
end
