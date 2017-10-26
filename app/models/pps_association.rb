class PpsAssociation < ApplicationRecord
  belongs_to :person
  belongs_to :title
  belongs_to :department
end
