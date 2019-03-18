class GroupRulesService
  # Recalculates all rules related to column and entity.
  # Similar to GroupRule.update_results() but only involves removing/adding results for a specific person
  # Note: Function assumes GroupRule is an 'is' rule as 'is not' are generally unsupported.
  #
  # @return [Array, Array] of outdated and current group IDs
  def self.update_results_for(column, entity)
    raise 'Expected Person object' unless entity.is_a?(Person)
    raise "Cannot update_results_for() for unknown column: #{column}" unless GroupRule.valid_columns.include? column.to_s

    Rails.logger.debug "GroupRuleResultSet: Updating results for person (ID #{entity.id}, #{entity.loginid}) for column #{column}"

    # Prepare to remove possibly expired existing rule results for this duple (person, column)
    existing_results = GroupRuleResult.includes(:group_rule_result_set).where(entity_id: entity.id, group_rule_result_sets: { column: column.to_s })
    new_results = []

    # Figure out which rules the entity matches specifically and add them
    case column
    when :title
      Title.where(id: entity.pps_associations.map(&:title_id)).each do |title|
        GroupRuleResultSet.where(column: 'title', value: title.code).each do |rule_set|
          Rails.logger.debug "Matched 'title' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :major
      entity.majors.each do |major|
        GroupRuleResultSet.where(column: 'major', value: major.name).each do |rule_set|
          Rails.logger.debug "Matched 'major' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :department
      entity.pps_associations.map { |assoc| assoc.department.code }.uniq.each do |dept_code|
        GroupRuleResultSet.where(column: 'department', value: dept_code).each do |rule_set|
          Rails.logger.debug "Matched 'department' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :admin_department
      entity.pps_associations.reject{ |assoc| assoc.admin_department_id == nil }.map { |assoc| assoc.admin_department.code }.uniq.each do |dept_code|
        GroupRuleResultSet.where(column: 'admin_department', value: dept_code).each do |rule_set|
          Rails.logger.debug "Matched 'admin_department' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :appt_department
      entity.pps_associations.reject{ |assoc| assoc.appt_department_id == nil }.map { |assoc| assoc.appt_department.code }.uniq.each do |dept_code|
        GroupRuleResultSet.where(column: 'appt_department', value: dept_code).each do |rule_set|
          Rails.logger.debug "Matched 'appt_department' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :business_office_unit
      entity.pps_associations.map { |assoc| assoc.department.business_office_unit&.dept_official_name }.uniq.each do |bou_name|
        GroupRuleResultSet.where(column: 'business_office_unit', value: bou_name).each do |rule_set|
          Rails.logger.debug "Matched 'business_office_unit' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :admin_business_office_unit
      entity.pps_associations.map { |assoc| assoc.admin_department.business_office_unit&.dept_official_name }.uniq.each do |bou_name|
        GroupRuleResultSet.where(column: 'admin_business_office_unit', value: bou_name).each do |rule_set|
          Rails.logger.debug "Matched 'admin_business_office_unit' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :appt_business_office_unit
      entity.pps_associations.map { |assoc| assoc.appt_department.business_office_unit&.dept_official_name }.uniq.each do |bou_name|
        GroupRuleResultSet.where(column: 'appt_business_office_unit', value: bou_name).each do |rule_set|
          Rails.logger.debug "Matched 'appt_business_office_unit' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :loginid
      GroupRuleResultSet.where(column: 'loginid', value: entity.loginid).each do |rule_set|
        Rails.logger.debug "Matched 'loginid' result set"
        new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
      end
    when :is_staff
      if entity.is_staff
        GroupRuleResultSet.where(column: 'is_staff').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          Rails.logger.debug "Matched 'is_staff' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :is_faculty
      if entity.is_faculty
        GroupRuleResultSet.where(column: 'is_faculty').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          Rails.logger.debug "Matched 'is_faculty' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :is_student
      if entity.is_student
        GroupRuleResultSet.where(column: 'is_student').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          Rails.logger.debug "Matched 'is_student' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :is_employee
      if entity.is_employee
        GroupRuleResultSet.where(column: 'is_employee').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          Rails.logger.debug "Matched 'is_employee' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :is_hs_employee
      if entity.is_hs_employee
        GroupRuleResultSet.where(column: 'is_hs_employee').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          Rails.logger.debug "Matched 'is_hs_employee' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :is_external
      if entity.is_external
        GroupRuleResultSet.where(column: 'is_external').each do |rule_set|
          # rule.value does not matter for the 'is_staff/employee/etc' column types
          Rails.logger.debug "Matched 'is_external' result set"
          new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
        end
      end
    when :sis_level_code
      GroupRuleResultSet.where(column: 'sis_level_code').each do |rule_set|
        next unless entity.sis_associations.where(level_code: rule_set.value).count.positive?

        Rails.logger.debug "Matched 'sis_level_code' result set"
        new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
      end
    when :pps_unit
      GroupRuleResultSet.where(column: 'pps_unit').each do |rule_set|
        relevent_title_ids = Title.where(unit: rule_set.value).pluck(:id)

        next unless entity.pps_associations.where(title_id: relevent_title_ids).count.positive?

        Rails.logger.debug "Matched 'pps_unit' result set"
        new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
      end
    when :pps_position_type
      GroupRuleResultSet.where(column: 'pps_position_type').each do |rule_set|
        next unless entity.pps_associations.where(position_type_code: rule_set.value).count.positive?

        Rails.logger.debug "Matched 'pps_position_type' result set"
        new_results << GroupRuleResult.new(entity_id: entity.id, group_rule_result_set_id: rule_set.id)
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

    current_group_ids = GroupRule.where(group_rule_result_set_id: touched_rule_set_ids).pluck(:group_id)

    # Group membership may have changed
    Group.where(id: current_group_ids + outdated_group_ids).each(&:touch)

    return [outdated_group_ids, current_group_ids]
  end

  # Finds all people IDs matching the given column and value, ignoring condition
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
      Rails.logger.warn "Unhandled GroupRulesService.find_matches logic for column type #{column}"
    end

    return []
  end

  # Call GroupRuleService.update_results_for() a single individual over multiple columns
  def self.update_results_for_columns(columns, person)
    raise 'Expected Array object' unless columns.is_a?(Array)
    raise 'Expected Person object' unless person.is_a?(Person)

    expired_group_ids = []
    current_group_ids = []

    columns.each do |column|
      raise 'Expected symbol' unless column.is_a?(Symbol)

      affected_group_ids = GroupRulesService.update_results_for(column, person)
      expired_group_ids << affected_group_ids[0]
      current_group_ids << affected_group_ids[1]
    end

    [expired_group_ids.flatten, current_group_ids.flatten]
  end

  # Main method to add a group rule to a group.
  # Ensures group members added due to group rule creation also gain their roles, if applicable.
  def self.add_group_rule(group, column, condition, value)
    raise 'Expected Group object' unless group.is_a?(Group)
    raise 'Expected String object' unless column.is_a?(String)
    raise 'Expected String object' unless condition.is_a?(String)
    raise 'Expected String object' unless value.is_a?(String)

    pre_removal_members = group.members
    gr = GroupRule.new
    gr.group = group
    gr.column = column
    gr.condition = condition
    gr.value = value
    gr.save!
    post_removal_members = group.members

    (post_removal_members - pre_removal_members).each do |added_member|
      RoleAssignmentsService.assign_group_roles_to_member(group, added_member)
    end

    return gr
  end

  # Main method to remove a group rule from a group.
  # Ensures group members lost due to group rule removal also lose their roles, if applicable.
  def self.remove_group_rule(group_rule)
    raise 'Expected GroupRule object' unless group_rule.is_a?(GroupRule)

    group = group_rule.group
    pre_removal_members = group.members
    group_rule.destroy
    post_removal_members = group.members

    (pre_removal_members - post_removal_members).each do |removed_member|
      RoleAssignmentsService.unassign_group_roles_from_member(group, removed_member)
    end
  end
end
