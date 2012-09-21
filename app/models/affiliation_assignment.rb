class AffiliationAssignment < ActiveRecord::Base
  using_access_control

  belongs_to :affiliation
  belongs_to :person
end
