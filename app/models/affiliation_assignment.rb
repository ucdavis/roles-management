class AffiliationAssignment < ActiveRecord::Base
  using_access_control

  belongs_to :affiliation, :touch => true
  belongs_to :person, :touch => true
end
