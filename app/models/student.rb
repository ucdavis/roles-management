class Student < ApplicationRecord
  belongs_to :person
  belongs_to :level, class_name: 'StudentLevel', optional: true
end
