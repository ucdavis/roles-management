# GroupRule stores the results of its rule in a cache using GroupRuleResult.
# Results are automatically recalculated in after_save if condition, column, or value has changed.
class GroupRule < ApplicationRecord
  VALID_COLUMNS = %w[title major loginid is_staff is_faculty is_student is_employee
                     is_external is_hs_employee sis_level_code pps_unit pps_position_type
                     department admin_department appt_department business_office_unit
                     admin_business_office_unit appt_business_office_unit employee_class].freeze

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
  belongs_to :result_set, class_name: 'GroupRuleResultSet', foreign_key: 'group_rule_result_set_id', optional: false

  before_validation :link_result_set
  after_destroy     :destroy_ruleset_if_empty

  # Needed by 'Group' when calculating rules
  def self.valid_columns
    VALID_COLUMNS
  end

  # Returns an array of all People matched by this GroupRule
  def results
    Person.where(id: result_set.results.pluck(:entity_id))
  end

  # Returns true if 'entity' matches this GroupRule
  def matches?(entity)
    case column.to_sym
    when :title
      return Title.where(id: entity.pps_associations.map(&:title_id)).map(&:code).include?(value)
    when :major
      return entity.majors.map(&:name).include?(value)
    when :department
      return entity.pps_associations.map { |assoc| assoc.department.code }.uniq.include?(value)
    when :admin_department
      return entity.pps_associations.reject{ |assoc| assoc.admin_department_id == nil }.map { |assoc| assoc.admin_department.code }.uniq.include?(value)
    when :appt_department
      return entity.pps_associations.reject{ |assoc| assoc.appt_department_id == nil }.map { |assoc| assoc.appt_department.code }.uniq.include?(value)
    when :business_office_unit
      return entity.pps_associations.map { |assoc| assoc.department.business_office_unit&.dept_official_name }.uniq.include?(value)
    when :admin_business_office_unit
      return entity.pps_associations.map { |assoc| assoc.admin_department.business_office_unit&.dept_official_name }.uniq.include?(value)
    when :appt_business_office_unit
      return entity.pps_associations.map { |assoc| assoc.appt_department.business_office_unit&.dept_official_name }.uniq.include?(value)
    when :loginid
      return entity.loginid == value
    when :is_staff
      return entity.is_staff
    when :is_faculty
      return entity.is_faculty
    when :is_student
      return entity.is_student
    when :is_employee
      return entity.is_employee
    when :is_hs_employee
      return entity.is_hs_employee
    when :is_external
      return entity.is_external
    when :sis_level_code
      return entity.sis_associations.map(&:level_code).include?(value)
    when :pps_unit
      relevent_title_ids = Title.where(unit: value).pluck(:id)
      return entity.pps_associations.where(title_id: relevent_title_ids).count.positive?
    when :pps_position_type
      return entity.pps_associations.where(position_type_code: value).count.positive?
    else
      Rails.logger.warn "Unhandled GroupRule.matches? logic for column type #{column}"
    end

    return false
  end

  def to_s
    "GroupRule(id: #{id}, column: #{column}, condition: #{condition}, value: #{value}"
  end

  # Recalculates rule results if column or value changed. Called after_save.
  def link_result_set
    # Avoid linking a result set if it already exists and is correct
    return if (self.result_set != nil) && (self.column == self.result_set.column) && (self.value == self.result_set.value)

    grs = GroupRuleResultSet.find_or_initialize_by(
      column: column,
      value: value
    )

    # We may be switching to a new ruleset. In that case, ensure the old one is
    # cleaned up as needed.
    destroy_ruleset_if_empty

    self.result_set = grs
  end

  private

  # Alert the GroupRuleResultSet in case it needs to destroy itself
  def destroy_ruleset_if_empty
    result_set&.destroy_if_unused
  end
end
