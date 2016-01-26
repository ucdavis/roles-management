class Student < ActiveRecord::Base
  using_access_control

  belongs_to :person
  belongs_to :level, :class_name => "StudentLevel"
end
