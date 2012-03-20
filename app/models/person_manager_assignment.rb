class PersonManagerAssignment < ActiveRecord::Base
  has_one :subordinate, :class_name => "Person", :foreign_key => "id", :primary_key => 'person_id'
  has_one :manager, :class_name => "Person", :foreign_key => "id", :primary_key => 'manager_id'
end
