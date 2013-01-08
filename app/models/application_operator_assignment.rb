class ApplicationOperatorAssignment < ActiveRecord::Base
  using_access_control

  validates_presence_of :application, :entity

  belongs_to :application
  belongs_to :entity
end
