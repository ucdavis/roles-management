class RenameMajorAssignmentToSisAssociations < ActiveRecord::Migration[5.1]
  def change
    rename_table :major_assignments, :sis_associations
  end
end
