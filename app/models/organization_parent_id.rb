# This class exists to model the relationship between organizations. An organization can have many children
# and should usually have a single parent. As of this writing, organizations can have multiple parents but
# this may change if we obtain cleaner data sources.
class OrganizationParentId < ActiveRecord::Base
  using_access_control

  belongs_to :organization
  belongs_to :parent_organization, :class_name => 'Organization', :foreign_key => :parent_org_id

  validates_presence_of :parent_org_id, :organization_id
  validates_uniqueness_of :parent_org_id, :scope => [:organization_id]

  validate :organization_cannot_relate_to_itself

  # Though this seems like 'group rule' logic, it must be done in this 'join table' class
  # as relationships can be created outside the Organization class causing
  # any Organization callbacks to go unused
  after_create :recalculate_organization_group_rules_if_necessary
  after_destroy :recalculate_organization_group_rules_if_necessary

  private

  def recalculate_organization_group_rules_if_necessary
    GroupRule.resolve_organization_parents!(organization)
  end

  # There's a similar check in Organization but it never hurts ...
  def organization_cannot_relate_to_itself
    if parent_organization.no_loops_in_organization_relationship_graph([organization_id]) == false
      errors.add(:base, "organization relationship cannot form loop in organization tree graph")
    end

    if organization_id == parent_org_id
      errors.add(:base, "organization canot be its own child or parent")
    end
  end
end
