class StudentLevel < ActiveRecord::Base
  using_access_control

  #attr_accessible :name
  has_many :students
end
