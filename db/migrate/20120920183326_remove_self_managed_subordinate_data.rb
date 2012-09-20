class RemoveSelfManagedSubordinateData < ActiveRecord::Migration
  def up
    PersonManagerAssignment.all.reject{ |x| x.person_id != x.manager_id }.each{ |assignment| assignment.delete }
  end

  def down
    puts "This migration is destructive and cannot be reversed."
  end
end
