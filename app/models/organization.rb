class Organization < ActiveRecord::Base
  using_access_control
  
  has_many :org_ids, :class_name => 'OrganizationOrgId', :dependent => :destroy
  has_many :parent_org_ids, :class_name => 'OrganizationParentId', :dependent => :destroy
  has_many :parent_organizations, :through => :parent_org_ids, :source => :parent_organization
  
  attr_accessible :dept_code, :name, :parent_organization_id

  before_validation :ensure_dept_code_is_left_padded
  
  has_many :organization_entity_associations
  has_many :entities, :through => :organization_entity_associations
  
  private

  # UCD department codes are left-padded to ensure a six-digit "number"
  # (stored as a string though)
  def ensure_dept_code_is_left_padded
    self.dept_code = "%06d" % self.dept_code.to_i if attribute_present?("dept_code")
  end
end
