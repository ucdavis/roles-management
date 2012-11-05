class MergeGroupChildrenAssignmentsIntoEntitiesGroupsRelationship < ActiveRecord::Migration
  def up
    Authorization.ignore_access_control(true)

    GroupChildrenAssignment.all.each do |gca|
      g = Group.find_by_id(gca.group_id)
      e = Entity.find_by_id(gca.child_id)

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
