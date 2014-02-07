class OrganizationParentId < ActiveRecord::Base
  using_access_control
  
  attr_accessible :parent_org_id, :organization_id
  
  belongs_to :organization
  belongs_to :parent_organization, :class_name => 'Organization', :foreign_key => :parent_org_id
  
  validates_presence_of :parent_org_id, :organization_id
  validates_uniqueness_of :parent_org_id, :scope => [:organization_id]
end
