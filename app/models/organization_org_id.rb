class OrganizationOrgId < ActiveRecord::Base
  using_access_control
  
  attr_accessible :org_id, :organization_id
  
  belongs_to :organization
  
  validates_presence_of :org_id, :organization_id
  validates_uniqueness_of :org_id
end
