# Holds GroupRuleResults so they may be shared to multiple GroupRules with identical values
class GroupRuleSet < ApplicationRecord
  validates_presence_of :column, :value
  validates_inclusion_of :column, in: GroupRule::VALID_COLUMNS
  validates_uniqueness_of :column, scope: [:condition, :value]
  validates_inclusion_of :condition, in: [true, false]

  validate do |grs|
    if (grs.column == 'is_staff' || grs.column == 'is_faculty' || grs.column == 'is_student' || grs.column == 'is_employee') && grs.value != 't'
      grs.errors[grs.column] << "Must use true value ('t'). Use 'is not' for false values."
    end
  end

  # Ensure column, condition, and value are immutable
  validate do
    if persisted?
      if column_changed?
        errors.add(:column, "Attribute 'column' is immutable")
      elsif condition_changed?
        errors.add(:condition, "Attribute 'condition' is immutable")
      elsif value_changed?
        errors.add(:value, "Attribute 'value' is immutable")
      end
    end
  end

  after_create do |grs|
    grs.update_results
  end

  has_many :rules, class_name: 'GroupRule'
  has_many :results, class_name: 'GroupRuleResult', dependent: :destroy

  # Class method to recalculate all rules related to column and person_id.
  # Similar to update_results() but only involves removing/adding results for a specific person
  # Note: Function assumes GroupRule is an 'is' rule as 'is not' are generally unsupported.
  def self.update_results_for(column, person_id)
    touched_rule_set_ids = [] # Record all groups touched by rule changes as they will need to recalculate their members

    unless GroupRule.valid_columns.include? column.to_s
      raise "Cannot update_results_for() for unknown column '#{column}'"
    end

    entity = Person.find_by(id: person_id)
    unless entity
      logger.warn "Could not find person with ID #{person_id}"
      return
    end

    logger.debug "Updating results for person with ID #{person_id} for column #{column}"

    # Remove any existing rule results for this (person, column) duple
    outdated_results = GroupRuleResult.includes(:group_rule_set).where(entity_id: person_id, group_rule_sets: { column: column.to_s })
    touched_group_ids = outdated_results.map { |result| result.group_rule_set.rules.map{ |r| r.group.id } }.flatten
    logger.debug "Expiring #{outdated_results.length} outdated results"
    outdated_results.destroy_all

    # Figure out which rules the entity matches specifically and add them
    case column
    when :title
      if entity.title
        GroupRuleSet.where(column: 'title', value: entity.title.name).each do |rule_set|
          logger.debug "Matched 'title is' rule. Recording result."
          rule_set.results << GroupRuleResult.new(entity_id: person_id)
          touched_rule_set_ids << rule_set.id
        end
      end
    when :major
      entity.majors.each do |major|
        GroupRuleSet.where(column: 'major', value: major.name).each do |rule_set|
          logger.debug "Matched 'major is' rule. Recording result."
          rule_set.results << GroupRuleResult.new(entity_id: person_id)
          touched_rule_set_ids << rule_set.id
        end
      end
    when :affiliation
      entity.affiliations.map(&:name).uniq.each do |aff_name|
        GroupRuleSet.where(column: 'affiliation', value: aff_name).each do |rule_set|
          logger.debug "Matched 'affiliation is' rule. Recording result."
          rule_set.results << GroupRuleResult.new(entity_id: person_id)
          touched_rule_set_ids << rule_set.id
        end
      end
    when :department
      entity.pps_associations.map { |assoc| assoc.department.officialName }.uniq.each do |dept_name|
        GroupRuleSet.where(column: 'department', value: dept_name).each do |rule_set|
          logger.debug "Matched 'department is' rule. Recording result."
          rule_set.results << GroupRuleResult.new(entity_id: person_id)
          touched_rule_set_ids << rule_set.id
        end
      end
    when :organization
      # FIXME
      # This is incorrect because if the entity is only a member of a child organization with no rules
      # but the child organization's parent has a rule, this will never do anything (right?)
      entity.organizations.map(&:name).uniq.each do |org_name|
        GroupRuleSet.where(column: 'organization', value: org_name).each do |rule_set|
          logger.debug "Matched 'Organization is' rule. Recording result."
          rule_set.results << GroupRuleResult.new(entity_id: person_id)
          touched_rule_set_ids << rule_set.id
        end

        touched_group_ids << GroupRule.resolve_target_assign_organization_parents!(Organization.find_by(name: org_name), person_id)
      end
    when :loginid
      GroupRuleSet.where(column: 'loginid', value: entity.loginid).each do |rule_set|
        logger.debug "Matched 'loginid is' rule. Recording result."
        rule_set.results << GroupRuleResult.new(entity_id: person_id)
        touched_rule_set_ids << rule_set.id
      end
    when :is_staff
      if entity.is_staff
        GroupRuleSet.where(column: 'is_staff').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          logger.debug "Matched 'is_staff' rule. Recording result."
          rule_set.results << GroupRuleResult.new(entity_id: person_id)
          touched_rule_set_ids << rule_set.id
        end
      end
    when :is_faculty
      if entity.is_faculty
        GroupRuleSet.where(column: 'is_faculty').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          logger.debug "Matched 'is_faculty' rule. Recording result."
          rule_set.results << GroupRuleResult.new(entity_id: person_id)
          touched_rule_set_ids << rule_set.id
        end
      end
    when :is_student
      if entity.is_student
        GroupRuleSet.where(column: 'is_student').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          logger.debug "Matched 'is_student' rule. Recording result."
          rule_set.results << GroupRuleResult.new(entity_id: person_id)
          touched_rule_set_ids << rule_set.id
        end
      end
    when :is_employee
      if entity.is_employee
        GroupRuleSet.where(column: 'is_employee').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          logger.debug "Matched 'is_employee' rule. Recording result."
          rule_set.results << GroupRuleResult.new(entity_id: person_id)
          touched_rule_set_ids << rule_set.id
        end
      end
    when :sis_level_code
      GroupRuleSet.where(column: 'sis_level_code').each do |rule_set|
        if entity.sis_associations.where(level_code: rule_set.value).count.positive?
          logger.debug "Matched 'sis_level_code' rule. Recording result."
          rule_set.results << GroupRuleResult.new(entity_id: person_id)
          touched_rule_set_ids << rule_set.id
        end
      end
    when :pps_unit
      GroupRuleSet.where(column: 'pps_unit').each do |rule_set|
        relevent_title_ids = Title.where(unit: rule_set.value).pluck(:id)

        if entity.pps_associations.where(title_id: relevent_title_ids).count.positive?
          logger.debug "Matched 'pps_unit' rule. Recording result."
          rule_set.results << GroupRuleResult.new(entity_id: person_id)
          touched_rule_set_ids << rule_set.id
        end
      end
    when :pps_position_type
      GroupRuleSet.where(column: 'pps_position_type').each do |rule_set|
        if entity.pps_associations.where(position_type_code: rule_set.value).count.positive?
          logger.debug "Matched 'pps_position_type' rule. Recording result."
          rule_set.results << GroupRuleResult.new(entity_id: person_id)
          touched_rule_set_ids << rule_set.id
        end
      end
    end

    touched_rule_set_ids = touched_rule_set_ids.flatten.uniq
    affected_group_ids = GroupRule.where(group_rule_set_id: touched_rule_set_ids).pluck(:group_id)

    # Group membership may have changed. Touch to invalidate any caches.
    Group.where(id: affected_group_ids).each(&:touch)
  end

  # Calculate the results of the rule and cache in GroupRuleResult instances
  def update_results
    p = []

    logger.debug "Updating results for group rule set ##{id}"

    case column
    when 'title'
      title = Title.find_by_name(value)
      unless title.nil?
        p += title.people.select(:id)
      end
    when 'major'
      major = Major.find_by_name(value)
      unless major.nil?
        p += major.people.select(:id)
      end
    when 'affiliation'
      affiliation = Affiliation.find_by_name(value)
      unless affiliation.nil?
        p += affiliation.people.select(:id)
      end
    when 'department'
      department = Department.find_by(officialName: value)
      if department.nil?
        logger.warn 'Department not found'
      else
        ps = department.people.select(:id)
        logger.debug "Adding #{ps.length} people to a 'Department is...' GroupRule"
        p += ps
      end
    when 'organization'
      organization = Organization.includes(:entities).find_by_name(value)
      if organization
        # We do not consider groups which belong to organizations in our calculations by design
        p += organization.flattened_entities
      else
        logger.warn 'Organization not found'
      end
    when 'loginid'
      p += Person.where(loginid: value).select(:id)
    when 'is_staff'
      p += Person.where(is_staff: true).select(:id)
    when 'is_faculty'
      p += Person.where(is_faculty: true).select(:id)
    when 'is_student'
      p += Person.where(is_student: true).select(:id)
    when 'is_employee'
      p += Person.where(is_employee: true).select(:id)
    when 'sis_level_code'
      p += SisAssociation.where(level_code: value).pluck(:entity_id).map { |e_id| OpenStruct.new(id: e_id) }
    when 'pps_unit'
      title_ids = Title.where(unit: value).pluck(:id)
      p += PpsAssociation.where(title_id: title_ids).pluck(:person_id).map { |e_id| OpenStruct.new(id: e_id) }
    when 'pps_position_type'
      p += PpsAssociation.where(position_type_code: value).pluck(:person_id).map { |e_id| OpenStruct.new(id: e_id) }

    end

    # Save the result in GroupRuleResults
    results.destroy_all

    p.each do |e|
      results << GroupRuleResult.new(entity_id: e.id)
    end

    logger.debug "Updated group rule set ##{id} to have #{results.length} results"
  end

  def destroy_if_unused
    destroy if rules.empty?
  end
end
