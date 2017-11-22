class Department < ApplicationRecord
  has_many :pps_associations
  has_many :people, through: :pps_associations
end
