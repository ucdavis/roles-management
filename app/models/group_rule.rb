# GroupRule stores the results of its rule in a cache using GroupRuleResult.
# Results are automatically recalculated in after_save if condition, column, or value has changed.
class GroupRule < ApplicationRecord
  VALID_COLUMNS = %w[title major affiliation loginid department organization is_staff is_faculty
                     is_student is_employee sis_level_code pps_unit pps_position_type].freeze

  validates_presence_of :condition, :column, :value, :group_id
  validates_inclusion_of :condition, in: %w[is is\ not]
  validates_inclusion_of :column, in: VALID_COLUMNS
  validate do |gr|
    if (gr.column == 'is_staff' || gr.column == 'is_faculty' || gr.column == 'is_student' || gr.column == 'is_employee') && gr.value != 't'
      gr.errors[gr.column] << "Must use true value ('t'). Use 'is not' for false values."
    end
  end

  belongs_to :group, touch: true
  belongs_to :result_set, class_name: 'GroupRuleSet', foreign_key: 'group_rule_set_id'

  after_save    :link_result_set
  after_destroy :alert_ruleset

  # Needed by 'Group' when calculating rules
  def self.valid_columns
    VALID_COLUMNS
  end

  # Returns an array of all People matched by this GroupRule
  def results
    Person.where(id: result_set.results.pluck(:entity_id))
  end

  # This function is used by OrganizationParentId to touch parent(s) GroupRuleResults when relationships are formed
  # between organizations.
  # It takes the entities 'organization' and ensures their names are propagated up through the GroupRuleResults.
  # It does this by simply invalidating each entity in the detaching organization and forcing their 'Organization'
  # rules to be re-calculated.
  def self.update_organization_parents(organization)
    Rails.logger.debug "Will traverse entities of '#{organization.name}' and call resolve_target_assign_organization_parents!. There are #{organization.entity_ids.length} entities to traverse."

    organization.entity_ids.each do |entity_id|
      GroupRuleSet.update_results_for(:organization, entity_id)
    end
  end

  # Assumes rule is 'Organization is...'
  # This function recurses through an organization's parents (and their parents and their parents and...)
  # looks for any GroupRules associated with that organization. If it finds any, it adds entity_id
  # as a valid GroupRuleResult.
  # The opposite behavior (removing an entity) is handled by the fact that GroupRuleSet.update_results_for
  # starts by removing all GroupRuleResults for an entity_id.
  def self.resolve_target_assign_organization_parents!(organization, entity_id)
    touched_group_ids = []

    Rails.logger.debug "Called for organzation \"#{organization.name}\"'s parents on #{entity_id}. There are #{organization.parent_organizations.length} parent(s)."

    organization.parent_organizations.each do |parent|
      # Find all rules affecting this parent
      rule_sets = GroupRuleSet.where(column: 'organization', condition: true, value: parent.name)

      Rails.logger.debug "Found #{rule_sets.length} rule sets for parent \"#{parent.name}\""

      rule_sets.each do |rule_set|
        # Add the entity to the rule's results
        rule_set.results << GroupRuleResult.new(entity_id: entity_id)
        touched_group_ids << GroupRule.where(group_rule_set_id: rule_set.id).pluck(:group_id)
      end

      # Do the same for this parent's parents
      touched_group_ids << GroupRule.resolve_target_assign_organization_parents!(parent, entity_id)
    end

    return touched_group_ids.flatten.uniq # rubocop:disable Style/RedundantReturn
  end

  private

  # Recalculates group members if anything changed. Called after_save.
  def link_result_set
    return unless column_changed? || condition_changed? || value_changed?
    return unless column.present? && condition.present? && value.present?

    grs = GroupRuleSet.find_or_create_by(
      column: column,
      condition: condition == 'is',
      value: value
    )

    # We may be switching to a new ruleset. In that case, ensure the old one is
    # cleaned up as needed.
    alert_ruleset

    self.result_set = grs
  end

  # Alert the GroupRuleSet in case it needs to destroy itself
  def alert_ruleset
    result_set.destroy_if_unused
  end
end
