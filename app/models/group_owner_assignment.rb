class GroupOwnerAssignment < ActiveRecord::Base
  belongs_to :group
  belongs_to :owner, :class_name => "Person"
end
