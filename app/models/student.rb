class Student < ActiveRecord::Base
  belongs_to :person
  belongs_to :level, :class_name => "StudentLevel"
end
