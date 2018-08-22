# Holds GroupRuleResults so they may be shared to multiple GroupRules with identical values
class GroupRuleResultSet < ApplicationRecord
  has_many :rules, class_name: 'GroupRule'
  has_many :results, class_name: 'GroupRuleResult', dependent: :destroy

  validates_presence_of :column, :value
  validates_inclusion_of :column, in: GroupRule::VALID_COLUMNS
  validates_uniqueness_of :column, scope: :value

  validate do |grs|
    if (grs.column == 'is_staff' ||
        grs.column == 'is_faculty' ||
        grs.column == 'is_student' ||
        grs.column == 'is_employee' ||
        grs.column == 'is_hs_employee' ||
        grs.column == 'is_external') && (grs.value != 't' && grs.value != '1')
      grs.errors[grs.column] << "Must use true value ('t' or '1'). Use 'is not' for false values."
    end
  end

  # Ensure column and value are immutable
  validate do
    if persisted?
      if column_changed?
        errors.add(:column, "Attribute 'column' is immutable")
      elsif value_changed?
        errors.add(:value, "Attribute 'value' is immutable")
      end
    end
  end

  # Need to calculate results when a new GroupRuleResultSet is created, typically
  # by being linked into existence when a GroupRule is created.
  after_create do |grs|
    grs.update_results
  end

  after_touch do |_grs|
    Rails.logger.debug "GroupRuleResultSet #{id}: after_touch will touch each rule, count #{rules.length}"
    rules.each(&:touch)
  end

  # Class method to recalculate all rules related to column and person_id.
  # Similar to update_results() but only involves removing/adding results for a specific person
  # Note: Function assumes GroupRule is an 'is' rule as 'is not' are generally unsupported.
  def self.update_results_for(column, person_id)
    Rails.logger.debug 'GroupRuleResultSet: update_results_for() called'

    unless GroupRule.valid_columns.include? column.to_s
      raise "Cannot update_results_for() for unknown column '#{column}'"
    end

    entity = Person.find_by(id: person_id)
    unless entity
      logger.warn "Could not find person with ID #{person_id}"
      return
    end

    Rails.logger.debug "GroupRuleResultSet: Updating results for person (ID #{person_id}, #{entity.loginid}) for column #{column}"

    # Prepare to remove possibly expired existing rule results for this duple (person, column)
    existing_results = GroupRuleResult.includes(:group_rule_result_set).where(entity_id: person_id, group_rule_result_sets: { column: column.to_s })
    new_results = []

    # Figure out which rules the entity matches specifically and add them
    case column
    when :title
      Title.where(id: entity.pps_associations.map(&:title_id)).each do |title|
        GroupRuleResultSet.where(column: 'title', value: title.name).each do |rule_set|
          Rails.logger.debug "Matched 'title' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :major
      entity.majors.each do |major|
        GroupRuleResultSet.where(column: 'major', value: major.name).each do |rule_set|
          Rails.logger.debug "Matched 'major' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :department
      entity.pps_associations.map { |assoc| assoc.department.code }.uniq.each do |dept_code|
        GroupRuleResultSet.where(column: 'department', value: dept_code).each do |rule_set|
          Rails.logger.debug "Matched 'department' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :admin_department
      entity.pps_associations.reject{ |assoc| assoc.admin_department_id == nil }.map { |assoc| assoc.admin_department.code }.uniq.each do |dept_code|
        GroupRuleResultSet.where(column: 'admin_department', value: dept_code).each do |rule_set|
          Rails.logger.debug "Matched 'admin_department' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :appt_department
      entity.pps_associations.reject{ |assoc| assoc.appt_department_id == nil }.map { |assoc| assoc.appt_department.code }.uniq.each do |dept_code|
        GroupRuleResultSet.where(column: 'appt_department', value: dept_code).each do |rule_set|
          Rails.logger.debug "Matched 'appt_department' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :business_office_unit
      entity.pps_associations.map { |assoc| assoc.department.business_office_unit&.dept_official_name }.uniq.each do |bou_name|
        GroupRuleResultSet.where(column: 'business_office_unit', value: bou_name).each do |rule_set|
          Rails.logger.debug "Matched 'business_office_unit' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :admin_business_office_unit
      entity.pps_associations.map { |assoc| assoc.admin_department.business_office_unit&.dept_official_name }.uniq.each do |bou_name|
        GroupRuleResultSet.where(column: 'admin_business_office_unit', value: bou_name).each do |rule_set|
          Rails.logger.debug "Matched 'admin_business_office_unit' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :appt_business_office_unit
      entity.pps_associations.map { |assoc| assoc.appt_department.business_office_unit&.dept_official_name }.uniq.each do |bou_name|
        GroupRuleResultSet.where(column: 'appt_business_office_unit', value: bou_name).each do |rule_set|
          Rails.logger.debug "Matched 'appt_business_office_unit' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :loginid
      GroupRuleResultSet.where(column: 'loginid', value: entity.loginid).each do |rule_set|
        Rails.logger.debug "Matched 'loginid' result set"
        new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
      end
    when :is_staff
      if entity.is_staff
        GroupRuleResultSet.where(column: 'is_staff').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          Rails.logger.debug "Matched 'is_staff' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :is_faculty
      if entity.is_faculty
        GroupRuleResultSet.where(column: 'is_faculty').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          Rails.logger.debug "Matched 'is_faculty' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :is_student
      if entity.is_student
        GroupRuleResultSet.where(column: 'is_student').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          Rails.logger.debug "Matched 'is_student' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :is_employee
      if entity.is_employee
        GroupRuleResultSet.where(column: 'is_employee').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          Rails.logger.debug "Matched 'is_employee' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :is_hs_employee
      if entity.is_hs_employee
        GroupRuleResultSet.where(column: 'is_hs_employee').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          Rails.logger.debug "Matched 'is_hs_employee' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :is_external
      if entity.is_external
        GroupRuleResultSet.where(column: 'is_external').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          Rails.logger.debug "Matched 'is_external' result set"
          new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :sis_level_code
      GroupRuleResultSet.where(column: 'sis_level_code').each do |rule_set|
        next unless entity.sis_associations.where(level_code: rule_set.value).count.positive?

        Rails.logger.debug "Matched 'sis_level_code' result set"
        new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
      end
    when :pps_unit
      GroupRuleResultSet.where(column: 'pps_unit').each do |rule_set|
        relevent_title_ids = Title.where(unit: rule_set.value).pluck(:id)

        next unless entity.pps_associations.where(title_id: relevent_title_ids).count.positive?

        Rails.logger.debug "Matched 'pps_unit' result set"
        new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
      end
    when :pps_position_type
      GroupRuleResultSet.where(column: 'pps_position_type').each do |rule_set|
        next unless entity.pps_associations.where(position_type_code: rule_set.value).count.positive?

        Rails.logger.debug "Matched 'pps_position_type' result set"
        new_results << GroupRuleResult.new(entity_id: person_id, group_rule_result_set_id: rule_set.id)
      end
    end

    existing_results = existing_results.to_a

    outdated_results = existing_results.reject do |er|
      new_results.reject! { |nr| (nr.entity_id == er.entity_id) && (nr.group_rule_result_set_id == er.group_rule_result_set_id) } != nil
    end

    outdated_group_ids = outdated_results.map { |result| result.group_rule_result_set.rules.map { |r| r.group.id } }.flatten
    Rails.logger.debug "Expiring #{outdated_results.length} results"
    outdated_results.each(&:destroy)

    # Add new results
    touched_rule_set_ids = []
    Rails.logger.debug "Adding #{new_results.length} results"
    new_results.each do |nr|
      touched_rule_set_ids << nr.group_rule_result_set_id
      nr.save!
    end

    touched_rule_set_ids = touched_rule_set_ids.flatten.uniq
    affected_group_ids = GroupRule.where(group_rule_result_set_id: touched_rule_set_ids).pluck(:group_id) + outdated_group_ids

    # Group membership may have changed
    Group.where(id: affected_group_ids).each(&:touch)
  end

  # Calculate the results of the rule and cache in GroupRuleResult instances
  def update_results
    Rails.logger.debug "GroupRuleResultSet #{id}: Updating results for group rule set ##{id}"

    p = GroupRule.find_matches(column, value)

    # Compare new and existing results to selectively destroy/create GroupRuleResult records as needed
    existing_results = results.to_a
    new_results = p.uniq.map { |e| GroupRuleResult.new(entity_id: e.id, group_rule_result_set_id: id) }

    outdated_results = existing_results.reject do |er|
      new_results.reject! { |nr| (nr.entity_id == er.entity_id) && (nr.group_rule_result_set_id == er.group_rule_result_set_id) } != nil
    end

    outdated_results.each(&:destroy)
    new_results.each do |nr|
      results << nr
    end

    update_occurred = !(outdated_results.empty? && new_results.empty?)

    if update_occurred
      self.touch # rubocop:disable Style/RedundantSelf
      Rails.logger.debug "GroupRuleResultSet #{id}: Updated group rule set ##{id} to have #{results.length} result(s)"
    else
      Rails.logger.debug "GroupRuleResultSet #{id}: No update necessary for group rule set ##{id} (has #{results.length} result(s))"
    end
  end

  def destroy_if_unused
    destroy if rules.empty?
  end
end
