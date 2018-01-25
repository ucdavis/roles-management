# Group shares many attributes with entity.
class Group < Entity
  has_many :memberships, class_name: 'GroupMembership', dependent: :destroy
  has_many :role_assignments, foreign_key: 'entity_id', dependent: :destroy
  has_many :roles, through: :role_assignments, dependent: :destroy
  has_many :group_ownerships, dependent: :destroy
  has_many :owners, through: :group_ownerships, source: 'entity', dependent: :destroy
  has_many :application_ownerships, foreign_key: 'entity_id', dependent: :destroy
  has_many :application_operatorships, foreign_key: 'entity_id', dependent: :destroy
  has_many :group_operatorships, dependent: :destroy
  has_many :operators, through: :group_operatorships, source: 'entity', dependent: :destroy
  has_many :rules, foreign_key: 'group_id', class_name: 'GroupRule', dependent: :destroy

  validates_presence_of :name

  accepts_nested_attributes_for :rules, allow_destroy: true
  accepts_nested_attributes_for :memberships, allow_destroy: true

  after_create do |group|
    ActivityLog.info!("Created group #{group.name}.", ["group_#{group.id}", 'system'])
  end

  after_destroy do |group|
    ActivityLog.info!("Deleted group #{group.name}.", ['system'])
  end

  def as_json(_options = {})
    Rails.logger.info 'Group.as_json called'
    Rails.logger.info caller
    { id: id, name: name, type: 'Group', description: description,
      owners: owners.map { |o| { id: o.id, loginid: o.loginid, name: o.name } },
      operators: operators.map { |o| { id: o.id, loginid: o.loginid, name: o.name } },
      memberships: memberships.includes(:entity).map { |m| { id: m.id, entity_id: m.entity.id, name: m.entity.name, loginid: m.entity.loginid } },
      rules: rules.map { |r| { id: r.id, column: r.column, condition: r.condition, value: r.value } } }
  end

  # Returns identifying string for logging purposes. Other classes implement this too.
  # Format: (Class name:id,identifying fields)
  def log_identifier
    "(Group:#{id},#{name})"
  end

  def members
    Person.where(id: (memberships.pluck(:entity_id) + rule_member_ids).uniq)
  end

  def rule_members
    Person.where(id: rule_member_ids.uniq)
  end

  # Calculates (and resets) all group_members based on rules.
  # Will delete any *_member_assignment flagged as calculated and rebuild
  # from rules.
  # This algorithm starts with an empty set, then runs all 'is'
  # rules, intersecting those sets, then makes a second pass and
  # removes anyone who fails a 'is not' rule.
  def rule_member_ids
    results = []

    # Step One: Build groups out of each 'is' rule,
    #           grouping rules of similar type together via OR
    #           Note: we ignore the 'loginid' column as it is calculated separately
    # Produce an array of arrays: outer array items represent each column type used, inner arrays are all group rule IDs for that specific column type
    # e.g. id: 1 "organization is", id: 2 "organization is", id: 3 "department is" produces: [ [1,2] , [3] ]
    GroupRule.select(:group_rule_set_id, :column)
             .where(group_id: id)
             .where(condition: 'is')
             .where.not(column: 'loginid')
             .group_by(&:column)
             .map { |set| set[1].map(&:group_rule_set_id) }.each do |rule_set_id|
      results << GroupRuleResult.select(:entity_id)
                                .joins(:group_rule_set)
                                .where(group_rule_set_id: rule_set_id)
                                .map(&:entity_id)
    end

    logger.debug "Ending step one with #{results.length} results"

    # Step Two: AND all groups from step one together
    results = results.inject(results.first) { |sum, n| sum &= n }
    results = [] unless results # reduce/inject may return nil
    logger.debug "ANDing all results together yields #{results.length} results"

    # Step Three: Pass over the result from step two and
    # remove anybody who violates an 'is not' rule
    negative_results = []
    GroupRule.select(:group_rule_set_id, :column)
             .where(group_id: id)
             .where(condition: 'is not')
             .group_by(&:column)
             .map { |set| set[1].map(&:group_rule_set_id) }.each do |rule_set_id|
      negative_results << GroupRuleResult.select(:entity_id)
                                         .joins(:group_rule_set)
                                         .where(group_rule_set_id: rule_set_id)
                                         .map(&:entity_id)
    end

    results -= negative_results.flatten.uniq

    logger.debug "Removing any 'is not' violates yielded #{results.length} results"

    # Step Four: Process any 'loginid is' rules
    rules.select { |r| r.condition == 'is' && r.column == 'loginid' }.each do |rule|
      logger.debug "Processing loginid is rule #{rule.value}..."
      results << rule.result_set.results.map(&:entity_id)
    end

    logger.debug "'Login ID is' additions yields #{results.length} results"

    results.flatten!

    logger.debug "Calculated #{results.length} results"

    return results # rubocop:disable Style/RedundantReturn
  end
end
