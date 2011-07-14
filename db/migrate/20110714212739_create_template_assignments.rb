class CreateTemplateAssignments < ActiveRecord::Migration
  def self.up
    create_table :template_assignments do |t|
      t.integer :template_id
      t.integer :group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :template_assignments
  end
end
