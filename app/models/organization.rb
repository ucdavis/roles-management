class Organization < ActiveRecord::Base
  using_access_control
  include Cyclable
  
  has_many :org_ids, :class_name => 'OrganizationOrgId', :dependent => :destroy
  has_many :parent_org_ids, :class_name => 'OrganizationParentId', :dependent => :destroy
  has_many :parent_organizations, :through => :parent_org_ids, :source => :parent_organization
  
  has_many :child_org_ids, :class_name => 'OrganizationParentId', :foreign_key => :parent_org_id, :dependent => :destroy
  has_many :child_organizations, :through => :child_org_ids, :source => :organization
  
  attr_accessible :dept_code, :name, :parent_organization_id
  
  validate :organization_cannot_have_itself_as_child_or_parent
  validate :organization_is_not_its_parent_own_parent

  before_validation :ensure_dept_code_is_left_padded
  
  has_many :organization_entity_associations
  has_many :entities, :through => :organization_entity_associations
  
  # Returns all people associated with this organization and all organizations within
  # the children trees. Does _not_ include members of groups associated with any of
  # those organizations by design.
  def flattened_entities
    results = []
    
    # Add this organization's entities
    entities.where(:type == 'Person').each do |e|
      results << e
    end

    # Add all children organization's entities
    child_organizations.all.each do |o|
      o.flattened_entities.each do |e|
        results << e
      end
    end

    # Only return a unique list
    results.uniq{ |x| x.id }
  end
  
  # Returns true if child_org_name is found anywhere in this
  # organization's children tree
  def has_child_organization(child_org_name)
    child_organizations.all.each do |o|
      return true if child_org_name == o.name
      return true if o.has_child_organization(child_org_name)
    end
    
    return false
  end
  
  private
  
  # Simple sanity check
  def organization_cannot_have_itself_as_child_or_parent
    if parent_organizations.include? self
      errors[:base] << "Organization cannot be its own parent"
    end
    if child_organizations.include? self
      errors[:base] << "Organization cannot be its own child"
    end
  end
  
  # Commonly found invalid loop in the organization CSV data
  def organization_is_not_its_parent_own_parent
    parent_organizations.each do |parent|
      if parent.parent_organizations.include? self
        errors[:base] << "Organization cannot be a parent of its parent"
      end
    end
  end

  # UCD department codes are left-padded to ensure a six-digit "number"
  # (stored as a string though)
  def ensure_dept_code_is_left_padded
    self.dept_code = "%06d" % self.dept_code.to_i if attribute_present?("dept_code")
  end
end
