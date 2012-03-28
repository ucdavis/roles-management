class AddBackTemplateAssignmentTable < ActiveRecord::Migration
  def change
    create_table :template_assignments do |t|
      t.integer  :template_id
      t.integer  :person_id
      t.integer  :group_id
    end
  end
end
