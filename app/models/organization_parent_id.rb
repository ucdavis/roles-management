class OrganizationParentId < ActiveRecord::Base
  using_access_control
  
  attr_accessible :parent_org_id, :organization_id
  
  belongs_to :organization
  belongs_to :parent_organization, :class_name => 'Organization', :foreign_key => :parent_org_id
  
  validates_presence_of :parent_org_id, :organization_id
  validates_uniqueness_of :parent_org_id, :scope => [:organization_id]
  
  validate :organization_cannot_relate_to_itself
  
  private
  
  # There's a similar check in Organization but it never hurts ...
  def organization_cannot_relate_to_itself
    if organization_id == parent_org_id
      errors.add(:base, "organization canot be its own child or parent")
    end
  end
end
