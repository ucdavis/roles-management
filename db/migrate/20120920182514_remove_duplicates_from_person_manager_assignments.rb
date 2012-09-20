class RemoveDuplicatesFromPersonManagerAssignments < ActiveRecord::Migration
  def up
    (PersonManagerAssignment.all - PersonManagerAssignment.all.uniq_by{|r| [r.manager_id, r.person_id, r.ou_id]}).each{ |assignment| assignment.delete }
  end

  def down
    puts "This migration is destructive and therefore not reversible."
  end
end
