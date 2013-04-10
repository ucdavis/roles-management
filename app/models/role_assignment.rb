class RoleAssignment < ActiveRecord::Base
  using_access_control

  belongs_to :role
  belongs_to :entity
  validates :role_id, :entity_id, :presence => true
end
