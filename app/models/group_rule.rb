# GroupRule stores the results of its rule in a cache using GroupRuleResult.
# Results are automatically recalculated in after_save if condition, column, or value has changed.
class GroupRule < ApplicationRecord
  VALID_COLUMNS = %w[title major loginid department is_staff is_faculty is_student is_employee
                     is_external is_hs_employee sis_level_code pps_unit pps_position_type
                     business_office_unit admin_department appt_department].freeze

  validates_presence_of :condition, :column, :value, :group_id
  validates_inclusion_of :condition, in: %w[is is\ not]
  validates_inclusion_of :column, in: VALID_COLUMNS
  validate do |gr|
    if (gr.column == 'is_staff' ||
        gr.column == 'is_faculty' ||
        gr.column == 'is_student' ||
        gr.column == 'is_employee' ||
        gr.column == 'is_hs_employee' ||
        gr.column == 'is_external') && (gr.value != 't' && gr.value != '1')
      gr.errors[gr.column] << "Must use true value ('t' or '1'). Use 'is not' for false values."
    end
  end

  belongs_to :group, touch: true
  # result_set isn't optional but we don't want to create result_sets during validation in case
  # validation fails and we end up creating a dangling result set.
  belongs_to :result_set, class_name: 'GroupRuleResultSet', foreign_key: 'group_rule_result_set_id', optional: true

  before_save   :link_result_set
  after_destroy :destroy_ruleset_if_empty

  # Needed by 'Group' when calculating rules
  def self.valid_columns
    VALID_COLUMNS
  end

  # Returns an array of all People matched by this GroupRule
  def results
    Person.where(id: result_set.results.pluck(:entity_id))
  end

  private

  # Recalculates group members if anything changed. Called after_save.
  def link_result_set # rubocop:disable Metrics/CyclomaticComplexity
    return unless column_changed? || condition_changed? || value_changed?
    return unless column.present? && condition.present? && value.present?

    grs = GroupRuleResultSet.find_or_create_by(
      column: column,
      condition: condition == 'is',
      value: value
    )

    # We may be switching to a new ruleset. In that case, ensure the old one is
    # cleaned up as needed.
    destroy_ruleset_if_empty

    self.result_set = grs
  end

  # Alert the GroupRuleResultSet in case it needs to destroy itself
  def destroy_ruleset_if_empty
    result_set&.destroy_if_unused
  end
end
