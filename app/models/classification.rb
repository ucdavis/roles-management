class Classification < ActiveRecord::Base
  has_and_belongs_to_many :people
  has_and_belongs_to_many :titles
end
