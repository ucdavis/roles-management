class Affiliation < ActiveRecord::Base
  has_many :affiliation_assignments
  has_many :people, :through => :affiliation_assignments
end
