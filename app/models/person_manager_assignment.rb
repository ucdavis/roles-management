class PersonManagerAssignment < ActiveRecord::Base
  belongs_to :subordinate, :class_name => "Person", :foreign_key => "person_id"
  belongs_to :manager, :class_name => "Person"
end
