class Entity < ActiveRecord::Base
  using_access_control

  attr_accessible :name, :type, :owners, :operators

  has_many :group_owner_assignments
end
