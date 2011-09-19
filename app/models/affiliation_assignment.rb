class AffiliationAssignment < ActiveRecord::Base
  belongs_to :affiliation
  belongs_to :person
end
