class CreateSisAssociations < ActiveRecord::Migration[5.1]
  def up
    # Create sis_associations table
    create_table :sis_associations do |t|
      t.integer :major_id
      t.integer :entity_id

      t.timestamps
    end

    # Create MajorAssignments for the old Person belongs_to 'major' attribute
    Person.where('major_id is not null').each do |p|
      p.majors << Major.find_by_id(p.major_id)
    end

    remove_column :entities, :major_id
  end

  def down
    STDERR.puts 'This migration is not reversible.'
    exit(-1)
  end
end
