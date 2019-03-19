class GroupsService
  def self.rule_memberships_for_person(person_id)
    # Find all Groups excluding person_id via 'is not' rules
    excluded_group_ids = GroupRule.where(group_rule_result_set_id: GroupRuleResult.where(entity_id: person_id)
                                                      .select(:group_rule_result_set_id)
                                                      .map(&:group_rule_result_set_id))
                                  .where(condition: 'is not')
                                  .select(:group_id).pluck(:group_id).uniq

    # Find all GroupRules matching person_id via 'is' rules, groupped by group_id, excluding known
    # 'is not' rules
    matches = GroupRule.where(group_rule_result_set_id: GroupRuleResult.where(entity_id: person_id)
                                                      .select(:group_rule_result_set_id)
                                                      .map(&:group_rule_result_set_id))
                       .where(condition: 'is')
                       .where.not(group_id: excluded_group_ids)
                       .select(:group_id, :column)
                       .map { |gr| { group_id: gr.group_id, column: gr.column } }
                       .group_by { |g| g[:group_id] }

    group_ids = []

    # Finally, ensure person_id meets all rules to be in 'matches'
    matches.each do |group_id, rule_matches|
      # Count the number of 'is' group rules for this group and for each unique column type
      uniq_is_column_count = GroupRule.where(group_id: group_id).where(condition: 'is').select(:column).distinct.count

      # Count the number of 'is' matches for this group, for this person, for each unique column type
      person_uniq_is_column_count = rule_matches.map { |m| m[:column] }.uniq.length

      # In order to match this group, we must match each distinct column type as well (as 'is' rules are ANDed together)
      group_ids << group_id if uniq_is_column_count == person_uniq_is_column_count
    end

    return group_ids # rubocop:disable Style/RedundantReturn
  end

  # Calculates (and resets) all group_members based on rules.
  # Will delete any *_member_assignment flagged as calculated and rebuild
  # from rules.
  # This algorithm starts with an empty set, then runs all 'is'
  # rules, intersecting those sets, then makes a second pass and
  # removes anyone who fails a 'is not' rule.
  def self.rule_member_ids(group)
    results = []

    # Step One: Build groups out of each 'is' rule,
    #           grouping rules of similar type together via OR
    #           Note: we ignore the 'loginid' column as it is calculated separately
    # Produce an array of arrays: outer array items represent each column type used, inner arrays are all group rule IDs for that specific column type
    # e.g. id: 1 "organization is", id: 2 "organization is", id: 3 "department is" produces: [ [1,2] , [3] ]
    GroupRule.select(:group_rule_result_set_id, :column)
             .where(group_id: group.id)
             .where(condition: 'is')
             .where.not(column: 'loginid')
             .group_by(&:column)
             .map { |set| set[1].map(&:group_rule_result_set_id) }.each do |rule_set_ids|
      rule_set_results = GroupRuleResult.select(:entity_id)
                                .joins(:group_rule_result_set)
                                .where(group_rule_result_set_id: rule_set_ids)
                                .map(&:entity_id)
      results << rule_set_results
    end

    # Step Two: AND all groups from step one together
    results = results.inject(results.first) { |sum, n| sum &= n }
    results ||= [] # reduce/inject may return nil

    # Step Three: Pass over the result from step two and
    # remove anybody who violates an 'is not' rule
    negative_results = []
    GroupRule.select(:group_rule_result_set_id, :column)
             .where(group_id: group.id)
             .where(condition: 'is not')
             .group_by(&:column)
             .map { |set| set[1].map(&:group_rule_result_set_id) }.each do |rule_set_ids|
      negative_results << GroupRuleResult.select(:entity_id)
                                         .joins(:group_rule_result_set)
                                         .where(group_rule_result_set_id: rule_set_ids)
                                         .map(&:entity_id)
    end

    results -= negative_results.flatten.uniq

    # Step Four: Process any 'loginid is' rules
    group.rules.select { |r| r.condition == 'is' && r.column == 'loginid' }.each do |rule|
      # Rails.logger.debug "Processing loginid is rule #{rule.value}..."
      results << rule.result_set.results.map(&:entity_id)
    end

    results.flatten!

    return results # rubocop:disable Style/RedundantReturn
  end
end
