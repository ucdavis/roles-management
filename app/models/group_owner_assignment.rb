class GroupOwnerAssignment < ActiveRecord::Base
  belongs_to :group
  belongs_to :owner_person, :class_name => "Person"
  belongs_to :owner_group, :class_name => "Group"
end
