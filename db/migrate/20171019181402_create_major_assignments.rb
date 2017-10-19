class CreateMajorAssignments < ActiveRecord::Migration[5.1]
  def up
    # Create major_assignments table
    create_table :major_assignments do |t|
      t.integer :major_id
      t.integer :entity_id

      t.timestamps
    end

    # Create MajorAssignments for the old Person belongs_to 'major' attribute
    Person.where('major_id is not null').each do |p|
      p.majors << Major.find_by_id(p.major_id)
    end
  end

  def down
    STDERR.puts 'This migration is not reversible.'
    exit(-1)
  end
end
