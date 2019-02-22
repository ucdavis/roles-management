# GroupRule stores the results of its rule in a cache using GroupRuleResult.
# Results are automatically recalculated in after_save if condition, column, or value has changed.
class GroupRule < ApplicationRecord
  VALID_COLUMNS = %w[title major loginid is_staff is_faculty is_student is_employee
                     is_external is_hs_employee sis_level_code pps_unit pps_position_type
                     department admin_department appt_department business_office_unit
                     admin_business_office_unit appt_business_office_unit].freeze

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

  # Finds all people (as IDs) matching this GroupRule column and value, ignoring condition
  def self.find_matches(column, value)
    case column.to_sym
    when :title
      title_id = Title.where(code: value).pluck('id').first
      return [] if title_id.nil?
      return PpsAssociation.where(title_id: title_id).pluck(:person_id).map { |e_id| OpenStruct.new(id: e_id) }
    when :major
      major = Major.find_by_name(value)
      return [] if major.nil?
      return major.people.select(:id)
    when :department
      department = Department.find_by(code: value)
      return [] if department.nil?
      return department.people.select(:id)
    when :admin_department
      admin_department = Department.find_by(code: value)
      return [] if admin_department.nil?
      return PpsAssociation.where(admin_department_id: admin_department.id).pluck(:person_id).map { |e_id| OpenStruct.new(id: e_id) }
    when :appt_department
      appt_department = Department.find_by(code: value)
      return [] if appt_department.nil?
      return PpsAssociation.where(appt_department_id: appt_department.id).pluck(:person_id).map { |e_id| OpenStruct.new(id: e_id) }
    when :business_office_unit
      bou = BusinessOfficeUnit.find_by(dept_official_name: value)
      return [] if bou.nil?
      return bou.departments.map { |d| d.people.select(:id) }.flatten
    when :admin_business_office_unit
      bou = BusinessOfficeUnit.find_by(dept_official_name: value)
      return [] if bou.nil?
      return bou.departments.map { |d| d.admin_people.select(:id) }.flatten
    when :appt_business_office_unit
      bou = BusinessOfficeUnit.find_by(dept_official_name: value)
      return [] if bou.nil?
      return bou.departments.map { |d| d.appt_people.select(:id) }.flatten
    when :loginid
      return Person.where(loginid: value).select(:id)
    when :is_staff
      return Person.where(is_staff: true).select(:id)
    when :is_faculty
      return Person.where(is_faculty: true).select(:id)
    when :is_student
      return Person.where(is_student: true).select(:id)
    when :is_employee
      return Person.where(is_employee: true).select(:id)
    when :is_hs_employee
      return Person.where(is_hs_employee: true).select(:id)
    when :is_external
      return Person.where(is_external: true).select(:id)
    when :sis_level_code
      return SisAssociation.where(level_code: value).pluck(:entity_id).map { |e_id| OpenStruct.new(id: e_id) }
    when :pps_unit
      title_ids = Title.where(unit: value).pluck(:id)
      return PpsAssociation.where(title_id: title_ids).pluck(:person_id).map { |e_id| OpenStruct.new(id: e_id) }
    when :pps_position_type
      return PpsAssociation.where(position_type_code: value).pluck(:person_id).map { |e_id| OpenStruct.new(id: e_id) }
    else
      Rails.logger.warn "Unhandled GroupRule.find_matches logic for column type #{column}"
    end

    return []
  end

  private

  # Recalculates rule results if column or value changed. Called after_save.
  def link_result_set # rubocop:disable Metrics/CyclomaticComplexity
    return unless column_changed? || value_changed?
    return unless column.present? && value.present?

    grs = GroupRuleResultSet.find_or_create_by(
      column: column,
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
