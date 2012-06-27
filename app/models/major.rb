class Major < ActiveRecord::Base
  # attr_accessible :title, :body
  has_many :people
end
