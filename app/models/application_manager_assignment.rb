class ApplicationManagerAssignment < ActiveRecord::Base
  belongs_to :application
  belongs_to :manager, :class_name => "Person"
end
