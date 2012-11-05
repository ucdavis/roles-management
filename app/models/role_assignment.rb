class RoleAssignment < ActiveRecord::Base
  using_access_control

  belongs_to :role
  belongs_to :entity
  validates :role_id, :entity_id, :presence => true
  validate :must_be_owner_or_operator_of_application

  # Only allow roles to be assigned if the associated application
  # is owned or can be operated upon by the current user
  def must_be_owner_or_operator_of_application
    logger.error "Implementation needed."
  end
end
