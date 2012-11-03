class Entity < ActiveRecord::Base
  using_access_control

  has_many :group_owner_assignments
end
