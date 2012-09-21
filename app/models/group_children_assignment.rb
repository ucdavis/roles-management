class GroupChildrenAssignment < ActiveRecord::Base
  using_access_control

  belongs_to :group
  belongs_to :child, :class_name => "Group"
end
