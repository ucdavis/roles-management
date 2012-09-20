class PersonManagerAssignment < ActiveRecord::Base
  validates_uniqueness_of :manager_id, :scope => [:person_id, :ou_id]

  belongs_to :subordinate, :class_name => "Person", :foreign_key => "person_id"
  belongs_to :manager, :class_name => "Person"
  belongs_to :ou, :class_name => "Group"
end
