def class_exists?(class_name)
  klass = Module.const_get(class_name)
  return klass.is_a?(Class)
rescue NameError
  return false
end

# Necessary as updated code will have removed this class, causing the migration to fail.
unless class_exists? "GroupCalculatedMemberAssignment"
  class GroupCalculatedMemberAssignment < ActiveRecord::Base
  end
  class GroupExplicitMemberAssignment < ActiveRecord::Base
  end
end

class MergeExplicitAndCalculatedGroupMembershipTables < ActiveRecord::Migration
  # Merge calculated group memberships into explicit group memberships and rename
  def change
    add_column :group_explicit_member_assignments, :calculated, :boolean, :default => false
    
    Authorization.ignore_access_control(true)
    
    GroupCalculatedMemberAssignment.all.each do |gca|
      gea = GroupExplicitMemberAssignment.new
      gea.group_id = gca.group_id
      gea.entity_id = gca.entity_id
      gea.calculated = true
      gea.save
    end
    
    GroupCalculatedMemberAssignment.destroy_all
    
    Authorization.ignore_access_control(false)
    
    drop_table :group_calculated_member_assignments
    rename_table :group_explicit_member_assignments, :group_assignments
  end
end
