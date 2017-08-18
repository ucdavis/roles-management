class OrganizationEntityAssociation < ApplicationRecord
  belongs_to :organization, touch: true
  belongs_to :entity, touch: true
  belongs_to :title, optional: true

  validates_presence_of :organization_id, :entity_id
  validates_uniqueness_of :entity_id, scope: [:organization_id, :title_id]

  validate :only_people_hold_titles
  validate :groups_belong_to_only_one_organization

  after_create  { |oea|
    Sync.person_added_to_organization(Sync.encode(oea.entity), Sync.encode(oea.organization)) if oea.entity.person?

    # Though this seems like 'group rule' logic, it must be done in this 'join table' class
    # as organizations can be created outside the Organization class causing
    # any Organization callbacks to go unused.
    recalculate_organization_group_rules_if_necessary
  }
  after_destroy { |oea|
    Sync.person_removed_from_organization(Sync.encode(oea.entity), Sync.encode(oea.organization)) if oea.entity.person?

    recalculate_organization_group_rules_if_necessary
  }

  private

  def recalculate_organization_group_rules_if_necessary
    GroupRule.resolve_target!(:organization, self.entity_id)
    GroupRule.resolve_target!(:department, self.entity_id)
  end

  # Validate that any title assignment is associated with a 'Person'-type
  # entity, not a 'Group'-type entity as only people hold titles.
  def only_people_hold_titles
    if self.title_id
      if self.entity_id and not self.entity.person?
        errors.add(:title_id, "can only be set if associated entity is a Person")
      end
    end
  end

  # By definition, groups may only belong to one organization
  def groups_belong_to_only_one_organization
    if self.entity and self.entity.group?
      association = OrganizationEntityAssociation.find_by_entity_id_and_organization_id(self.entity_id, self.organization_id)
      if association and association.id != self.id
        errors.add(:base, "groups may only belong to one organization")
      end
    end
  end
end
