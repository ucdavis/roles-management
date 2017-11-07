# GroupRule stores the results of its rule in a cache using GroupRuleResult.
# Results are automatically recalculated in after_save if condition, column, or value has changed.
class GroupRule < ApplicationRecord
  VALID_COLUMNS = %w[title major affiliation loginid department organization is_staff is_faculty
                     is_student is_employee sis_level_code pps_unit].freeze

  validates_presence_of :condition, :column, :value, :group_id
  validates_inclusion_of :condition, in: %w[is is\ not]
  validates_inclusion_of :column, in: VALID_COLUMNS
  validate do |gr|
    if (gr.column == 'is_staff' || gr.column == 'is_faculty' || gr.column == 'is_student' || gr.column == 'is_employee') && gr.value != 't'
      gr.errors[gr.column] << "Must use true value ('t'). Use 'is not' for false values."
    end
  end

  belongs_to :group, touch: true
  has_many :results, class_name: 'GroupRuleResult', dependent: :destroy

  after_save :resolve_if_changed
  after_destroy :group_must_recalculate

  # Needed by 'Group' when calculating rules
  def self.valid_columns
    VALID_COLUMNS
  end

  # Class method to recalculate all rules related to column and entity_id.
  # Similar to resolve! but only involves removing/adding results for a specific person
  # Note: Function assumes GroupRule is an 'is' rule as 'is not' are generally unsupported.
  def self.resolve_target!(column, entity_id)
    touched_group_ids = [] # Record all groups touched by rule changes as they will need to recalculate their members

    Rails.logger.tagged 'GroupRule.resolve_target!' do
      unless VALID_COLUMNS.include? column.to_s
        raise "Cannot resolve_target for unknown column '#{column}'"
      end

      logger.info "Resolving target entity ID #{entity_id} for column #{column}"

      # Remove any existing rule results for this (person, column) duple
      expired_rule_results = GroupRuleResult.includes(:group_rule).where(entity_id: entity_id, group_rules: { column: column.to_s })
      touched_group_ids = expired_rule_results.map { |result| result.group_rule.group.id }
      logger.info "Expiring #{expired_rule_results.length} rules"
      expired_rule_results.destroy_all

      entity = Entity.find_by_id(entity_id)
      unless entity
        logger.warn "Could not find entity with ID #{entity_id}"
        return
      end

      # Figure out which rules the entity matches specifically and add them
      case column
      when :title
        if entity.title
          GroupRule.where(column: 'title').each do |rule|
            if rule.value == entity.title.name
              logger.info "Matched 'title is' rule. Recording result."
              rule.results << GroupRuleResult.new(entity_id: entity_id)
              touched_group_ids << rule.group.id
            end
          end
        end
      when :major
        entity.majors.each do |major|
          GroupRule.where(column: 'major').each do |rule|
            if rule.value == major.name
              logger.info "Matched 'major is' rule. Recording result."
              rule.results << GroupRuleResult.new(entity_id: entity_id)
              touched_group_ids << rule.group.id
            end
          end
        end
      when :affiliation
        entity.affiliations.each do |entity_affiliation|
          GroupRule.where(column: 'affiliation').each do |rule|
            if rule.value == entity_affiliation.name
              logger.info "Matched 'affiliation is' rule. Recording result."
              rule.results << GroupRuleResult.new(entity_id: entity_id)
              touched_group_ids << rule.group.id
            end
          end
        end
      when :department
        if entity.type == 'Group'
          logger.warn "Targeted entity for 'Department is' rule is a group #{entity.log_identifier}. Skipping ..."
        else
          entity.organizations.each do |organization|
            GroupRule.where(column: 'department').each do |rule|
              if rule.value == organization.name
                logger.info "Matched 'department is' rule. Recording result."
                rule.results << GroupRuleResult.new(entity_id: entity_id)
                touched_group_ids << rule.group.id
              end
            end
          end
        end
      when :organization
        # FIXME
        # This is incorrect because if the entity is only a member of a child organization with no rules
        # but the child organization's parent has a rule, this will never do anything (right?)
        entity.organizations.each do |organization|
          GroupRule.where(column: 'organization').each do |rule|
            if rule.value == organization.name
              logger.info "Matched 'Organization is' rule. Recording result."
              rule.results << GroupRuleResult.new(entity_id: entity_id)
              touched_group_ids << rule.group.id
            end
          end

          touched_group_ids << GroupRule.resolve_target_assign_organization_parents!(organization, entity_id)
        end
      when :loginid
        GroupRule.where(column: 'loginid').each do |rule|
          if rule.value == entity.loginid
            logger.info "Matched 'loginid is' rule. Recording result."
            rule.results << GroupRuleResult.new(entity_id: entity_id)
            touched_group_ids << rule.group.id
          end
        end
      when :is_staff
        GroupRule.where(column: 'is_staff').each do |rule|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          if entity.is_staff
            logger.info "Matched 'is_staff' rule. Recording result."
            rule.results << GroupRuleResult.new(entity_id: entity_id)
            touched_group_ids << rule.group.id
          end
        end
      when :is_faculty
        GroupRule.where(column: 'is_faculty').each do |rule|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          if entity.is_faculty
            logger.info "Matched 'is_faculty' rule. Recording result."
            rule.results << GroupRuleResult.new(entity_id: entity_id)
            touched_group_ids << rule.group.id
          end
        end
      when :is_student
        GroupRule.where(column: 'is_student').each do |rule|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          if entity.is_student
            logger.info "Matched 'is_student' rule. Recording result."
            rule.results << GroupRuleResult.new(entity_id: entity_id)
            touched_group_ids << rule.group.id
          end
        end
      when :is_employee
        GroupRule.where(column: 'is_employee').each do |rule|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          if entity.is_employee
            logger.info "Matched 'is_employee' rule. Recording result."
            rule.results << GroupRuleResult.new(entity_id: entity_id)
            touched_group_ids << rule.group.id
          end
        end
      when :sis_level_code
        GroupRule.where(column: 'sis_level_code').each do |rule|
          if entity.sis_associations.where(level_code: rule.value).count.positive?
            logger.info "Matched 'sis_level_code' rule. Recording result."
            rule.results << GroupRuleResult.new(entity_id: entity_id)
            touched_group_ids << rule.group.id
          end
        end
      when :pps_unit
        GroupRule.where(column: 'pps_unit').each do |rule|
          relevent_title_ids = Title.where(unit: rule.value).pluck(:id)

          if entity.pps_associations.where(title_id: relevent_title_ids).count.positive?
            logger.info "Matched 'pps_unit' rule. Recording result."
            rule.results << GroupRuleResult.new(entity_id: entity_id)
            touched_group_ids << rule.group.id
          end
        end

      end

      touched_group_ids.flatten.uniq.each do |touched_group_id|
        logger.info "Alerting group ##{touched_group_id} to recalculate as at least one of its rules were touched."
        Group.find_by_id(touched_group_id).recalculate_members!
      end
    end
  end

  # This function is used by OrganizationParentId to touch parent(s) GroupRuleResults when relationships are formed
  # between organizations.
  # It takes the entities 'organization' and ensures their names are propagated up through the GroupRuleResults.
  # It does this by simply invalidating each entity in the detaching organization and forcing their 'Organization'
  # rules to be re-calculated.
  def self.resolve_organization_parents!(organization)
    Rails.logger.tagged 'GroupRule.resolve_target!' do
      Rails.logger.debug "Will traverse entities of '#{organization.name}' and call resolve_target_assign_organization_parents!. There are #{organization.entity_ids.length} entities to traverse."

      organization.entity_ids.each do |entity_id|
        Rails.logger.debug "Calling GroupRule.resolve_target! for entity ID #{entity_id}"
        GroupRule.resolve_target!(:organization, entity_id)
      end
    end
  end

  # Assumes rule is 'Organization is...'
  # This function recurses through an organization's parents (and their parents and their parents and...)
  # looks for any GroupRules associated with that organization. If it finds any, it adds entity_id
  # as a valid GroupRuleResult.
  # The opposite behavior (removing an entity) is handled by the fact that resolve_target! begins its
  # algorithm by removing all GroupRuleResults for an entity_id.
  def self.resolve_target_assign_organization_parents!(organization, entity_id)
    touched_group_ids = []

    Rails.logger.tagged 'GroupRule.resolve_target_assign_organization_parents!' do
      Rails.logger.debug "Called for organzation \"#{organization.name}\"'s parents on #{entity_id}. There are #{organization.parent_organizations.length} parent(s)."

      organization.parent_organizations.each do |parent|
        # Find all rules affecting this parent
        rules = GroupRule.where(column: 'organization', condition: 'is', value: parent.name)

        Rails.logger.debug "Found #{rules.length} rules for parent \"#{parent.name}\""

        rules.each do |rule|
          # Add the entity to the rule's results
          rule.results << GroupRuleResult.new(entity_id: entity_id)
          touched_group_ids << rule.group.id
        end

        # Do the same for this parent's parents
        touched_group_ids << GroupRule.resolve_target_assign_organization_parents!(parent, entity_id)
      end
    end

    return touched_group_ids.flatten.uniq # rubocop:disable Style/RedundantReturn
  end

  # Calculate the results of the rule and cache in GroupRuleResult instances
  def resolve!
    p = []

    logger.info "Resolving (calculating) group rule ##{id}"

    if condition == 'is not'
      logger.warn " -- 'is not' condition will not be resolved within GroupRule"
    else
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
        department = Organization.find_by_name(value)
        if department.nil?
          logger.warn 'Department (Organization) not found'
        else
          ps = department.entities.select(:id)
          logger.debug "Adding #{ps.length} entities to a 'Department is...' GroupRule"
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

      end
    end

    # Save the result in GroupRuleResults
    results.destroy_all

    p.each do |e|
      results << GroupRuleResult.new(entity_id: e.id)
    end

    logger.info "Resolved group rule ##{id} to have #{results.length} results"
  end

  # Returns true if the given person satisfies the rule
  def matches(person_id) # rubocop:disable Metrics/AbcSize, Metrics/CyclomaticComplexity
    matched = nil

    person = Person.find_by_id(person_id)

    return false unless person

    case column
    when 'title'
      matched = person.title == Title.find_by_name(value)
    when 'major'
      matched = person.majors.include?(Major.find_by_name(value))
    when 'affiliation'
      matched = person.affiliations.include? Affiliation.find_by_name(value)
    when 'department'
      matched = person.organizations.include? Organization.find_by_name(value)
    when 'organization'
      matched = person.organizations.include? Organization.find_by_name(value)
    when 'loginid'
      matched = person.loginid == value
    when 'is_staff'
      matched = person.is_staff == truthy(value)
    when 'is_faculty'
      matched = person.is_faculty == truthy(value)
    when 'is_student'
      matched = person.is_student == truthy(value)
    when 'is_employee'
      matched = person.is_employee == truthy(value)
    when 'sis_level_code'
      matched = person.sis_associations.where(level_code: value).count.positive?
    when 'pps_unit'
      title_ids = Title.where(unit: value).pluck(:id)
      matched = person.pps_associations.where(title_id: title_ids).count.positive?
    end

    # 'cond' is a boolean representing this rule's 'is' or 'is not'
    return (condition == 'is') == matched # rubocop:disable Style/RedundantReturn
  end

  private

  # Attempts to return true or false based on a wide variety of values
  def truthy(value) # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
    return true if value == 't'
    return false if value == 'f'
    return true if value == 'true'
    return false if value == 'false'
    return true if value == '1'
    return false if value == '0'
    return true if value == 1
    return false if value == 0 # rubocop:disable Style/NumericPredicate
    return value == true # rubocop:disable Style/RedundantReturn
  end

  # Recalculates group members if anything changed. Called after_save.
  def resolve_if_changed
    return unless saved_changes?

    resolve!
    group.recalculate_members!
  end

  # In after_destroy it's important the group recalculate members as this rule is gone
  def group_must_recalculate
    group.recalculate_members!
  end
end
