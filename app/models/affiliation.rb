class Affiliation < ApplicationRecord
  has_many :affiliation_assignments, dependent: :destroy
  has_many :people, through: :affiliation_assignments
end
