class MergeGroupChildrenAssignmentsIntoEntitiesGroupsRelationship < ActiveRecord::Migration
  def up
    Authorization.ignore_access_control(true)

    GroupChildrenAssignment.all.each do |gca|
      g = Group.find_by_id(('2' + gca.group_id.to_s).to_i)
      e = Entity.find_by_id(('2' + gca.child_id.to_s).to_i)

      g.entities << e

      g.save
    end

    Authorization.ignore_access_control(false)

    drop_table :group_children_assignments
  end

  def down
    puts "This migration should not be reversed."
  end
end
