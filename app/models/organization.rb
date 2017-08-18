class Organization < ApplicationRecord
  has_many :org_ids, :class_name => 'OrganizationOrgId', :dependent => :destroy
  has_many :parent_org_ids, :class_name => 'OrganizationParentId', :dependent => :destroy
  has_many :parent_organizations, :through => :parent_org_ids, :source => :parent_organization
  has_many :child_org_ids, :class_name => 'OrganizationParentId', :foreign_key => :parent_org_id, :dependent => :destroy
  has_many :child_organizations, :through => :child_org_ids, :source => :organization
  has_many :organization_entity_associations
  has_many :entities, :through => :organization_entity_associations
  has_many :organization_managers
  has_many :managers, :through => :organization_managers

  validate :no_loops_in_organization_relationship_graph
  before_validation :ensure_dept_code_is_left_padded

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
    child_organizations.to_a.each do |o| #all.each do |o|
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

  # Records all IDs found while traversing up the parent graph.
  # Algorithm ends either when a duplicate ID is found (indicates a loop)
  # or no more parents exist (indicates no loops).
  def no_loops_in_organization_relationship_graph(seen_ids = [])
    return false if seen_ids.include?(id)

    seen_ids << id

    parent_organizations.each do |parent|
      if parent.no_loops_in_organization_relationship_graph(seen_ids.dup) == false
        errors[:base] << "Organization parent/child relationships may not form loops in the organization tree graph"
        return false
      end
    end

    return true
  end

  private

  # UCD department codes are left-padded to ensure a six-digit "number"
  # (stored as a string though)
  def ensure_dept_code_is_left_padded
    self.dept_code = "%06d" % self.dept_code.to_i if attribute_present?("dept_code")
  end
end
