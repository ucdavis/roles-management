class Student < ActiveRecord::Base
  using_access_control

  attr_accessible :person_id, :student_level_id
  belongs_to :person
  belongs_to :level, :class_name => "StudentLevel"
end
