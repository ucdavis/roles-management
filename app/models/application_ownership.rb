class ApplicationOwnership < ActiveRecord::Base
  using_access_control

  belongs_to :application
  belongs_to :owner, :class_name => "Person"
end
