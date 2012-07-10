class Student < ActiveRecord::Base
  attr_accessible :person_id, :student_level_id
  belongs_to :person
  belongs_to :student_level
end
