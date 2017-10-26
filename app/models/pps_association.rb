class PpsAssociation < ApplicationRecord
  belongs_to :person
  belongs_to :title
  belongs_to :department

  # '1', 'Contract'
  # '2', 'Regular/Career'
  # '3', 'Limited, Formerly Casual'
  # '4', 'Casual/RESTRICTED-Students'
  # '5', 'Academic'
  # '6', 'Per Diem'
  # '7', 'Regular/Career Partial YEAR'
  # '8', 'Floater'
end
