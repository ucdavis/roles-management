class RenameStudentLevelIdInStudentToLevelId < ActiveRecord::Migration
  def change
    rename_column :students, :student_level_id, :level_id
  end
end
