class ApplicationOwnerAssignment < ActiveRecord::Base
  belongs_to :application
  belongs_to :owner, :class_name => "Person"
end
