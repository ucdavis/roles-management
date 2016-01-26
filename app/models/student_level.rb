class StudentLevel < ActiveRecord::Base
  using_access_control

  has_many :students
end
