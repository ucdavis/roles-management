class GroupChildrenAssignment < ActiveRecord::Base
  belongs_to :group
  belongs_to :child, :class_name => "Group"
end
