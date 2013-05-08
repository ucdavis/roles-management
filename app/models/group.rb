class Group < Entity
  using_access_control

  scope :ous, where(Group.arel_table[:code].not_eq(nil))
  scope :non_ous, where(Group.arel_table[:code].eq(nil))

  has_and_belongs_to_many :entities,
                          :after_add => Proc.new { |model| model.clear_cache_if_needed(true) },
                          :after_remove => Proc.new { |model| model.clear_cache_if_needed(true) }

  has_many :role_assignments, :foreign_key => "entity_id"
  has_many :roles, :through => :role_assignments, :dependent => :destroy

  has_many :group_owner_assignments
  has_many :owners, :through => :group_owner_assignments, :source => "entity", :dependent => :destroy

  has_many :group_operator_assignments
  has_many :operators, :through => :group_operator_assignments, :source => "entity", :dependent => :destroy

  has_many :rules, :foreign_key => 'group_id', :class_name => "GroupRule", :dependent => :destroy

  validates :name, :presence => true

  attr_accessible :name, :description, :type, :member_ids, :owner_ids, :operator_ids, :rules_attributes

  accepts_nested_attributes_for :rules,
                                :reject_if => lambda { |a| a[:value].blank? || a[:condition].blank? || a[:column].blank? },
                                :allow_destroy => true

  after_save :clear_cache_if_needed
  after_save :trigger_sync

  # Calculates all members, including those defined via rules.
  # If flatten is set to true, child groups are resolved recursively until only a list of people remains.
  # If flatten is false, any member groups will simply be returned as a group (i.e. not as the people _in_ that member group)
  def members(flatten = false)
    Rails.cache.fetch("entities/members/#{flatten}/#{id}") do
      members = []

      entities.each do |e|
        if flatten and e.type == "Group"
          e.members(true).each do |m|
            members << m
          end
        else
          members << e
        end
      end

      # Include members via rules
      members += rule_members

      # Only return a unique list
      members.uniq{|x| x.id}
    end
  end

  # Overriden to avoid having to use _destroy in Backbone/simplify client-side interaction
  def rules_attributes=(rule_attrs)
    ids_touched = [] # We'll remove any rules that weren't touched at the end

    # Add/update rules
    unless rule_attrs.nil?
      rule_attrs.each do |rule|
        if (rule[:id].to_s)[0..3] == "new_"
          # New rule
          r = GroupRule.new
          r.column = rule[:column]
          r.condition = rule[:condition]
          r.value = rule[:value]
          r.group_id = id
          r.save
          ids_touched << r.id
        else
          # Updating a rule
          r = GroupRule.find(rule[:id])
          r.column = rule[:column]
          r.condition = rule[:condition]
          r.value = rule[:value]
          r.save
          ids_touched << r.id
        end
      end
    end

    # Remove unnecessary ones
    rules.all.each do |r|
      unless ids_touched.include? r.id
        r.destroy
      end
    end
  end

  # Compute accessible applications
  def applications
    Rails.cache.fetch("entities/applications/#{id}") do
      apps = []

      # Add apps via roles explicitly assigned
      roles.each { |role| apps << role.application }

      apps
    end
  end

  # Returns tokenized members, including 'via' parameter to differentiate explicitly-assigned
  # vs. rule-resolved members
  def member_tokens
    Rails.cache.fetch("entities/member_tokens/#{id}") do
      result = []
      explicit_members = []
      resolved_members = []

      entities.each do |e|
        explicit_members << e
      end

      # Include members via rules
      resolved_members += rule_members

      # Unique members only
      explicit_members = explicit_members.uniq{|x| x.id}
      resolved_members = resolved_members.uniq{|x| x.id}

      result = resolved_members.map{ |x| { :id => x.id, :name => x.name, :readonly => true, :loginid => ((defined? x.loginid) ? x.loginid : nil ) } }.sort {|a,b| a[:name] <=> b[:name] }
      result += explicit_members.map{ |x| { :id => x.id, :name => x.name, :readonly => false, :loginid => ((defined? x.loginid) ? x.loginid : nil ) } }.sort {|a,b| a[:name] <=> b[:name] }

      result
    end
  end

  def owner_tokens
    owner_ids
  end

  def owner_tokens=(ids)
    self.owner_ids = ids.split(",")
  end

  def operator_tokens
    operator_ids
  end

  def operator_tokens=(ids)
    self.operator_ids = ids.split(",")
  end

  def entities_tokens=(ids)
    self.entity_ids = ids.split(",")
  end

  def member_ids=(ids)
    # We'll build these lists and assign them at the end
    e_ids = []
    logger.info "member_ids= start, self.entity_ids is:"
    logger.info self.entity_ids

    # Determine which members come from rules so we don't add them to the explicit list (causes dupes)
    r_members = []
    rule_members.each do |r|
      r_members += [r.id]
    end
    
    unless ids.nil?
      ids.each do |id|
        unless r_members.include? id
          e_ids << id
        end
      end
    end

    self.entity_ids = e_ids
    logger.info "member_ids= end, self.entity_ids is:"
    logger.info self.entity_ids
  end

  def as_json(options={})
    { :id => self.id, :name => self.name, :type => 'Group',
      :owners => self.owners.map{ |o| { id: o.id, loginid: o.loginid, name: o.name } },
      :operators => self.operators.map{ |o| { id: o.id, loginid: o.loginid, name: o.name } },
      :members => self.members.map{ |m| { id: m.id, name: m.name, loginid: m.loginid } },
      :rules => self.rules.map{ |r| { id: r.id, column: r.column, condition: r.condition, value: r.value } } }
  end

  # Returns all members via resolving group rules
  # This algorithm starts with an empty set, then runs all 'is'
  # rules, intersecting those sets, then makes a second pass and
  # removes anyone who fails a 'is not' rule.
  def rule_members
    Rails.cache.fetch("entities/rule_members/#{id}") do
      results = []

      # Step One: Build groups out of each 'is' rule,
      #           groupping rules of similar type together via OR
      #           Note: we ignore the 'loginid' column as it is calculated separately
      rules.where(:condition => "is").where(:column => GroupRule.valid_columns.reject{|x| x == "loginid"}).group_by(&:column).each do |ruleset|
        ruleset_results = []

        ruleset[1].each do |rule|
          ruleset_results << rule.resolve
        end

        results << ruleset_results.inject(ruleset_results.first) { |sum,m| sum |= m }
      end

      # Step Two: AND all groups from step one together
      result = results.inject(results.first) { |sum,m| sum &= m }

      if result
        # Step Three: Pass over the result from step two and
        # remove anybody who violates an 'is not' rule
        result = result.find_all{ |member|
          keep = true
          rules.where(:condition => "is not").each do |rule|
            keep &= rule.matches(member)
          end
          keep
        }
      end

      # Step Four: Process any 'loginid is' rules
      rules.where({:condition => "is", :column => "loginid"}).each do |rule|
        if result.nil?
          result = []
        end
        result << rule.resolve.at(0)
      end

      if result.nil?
        return []
      end

      result
    end
  end

  def trigger_sync
    logger.info "Group #{id}: trigger_sync called, calling trigger_sync on #{roles.length} roles"
    roles.all.each { |role| role.trigger_sync }
    return true
  end

  def clear_cache_if_needed(force_clear = false)
    if self.changed? or force_clear
      logger.debug "Clearing cache for group #{id}"
      Rails.cache.delete("entities/member_tokens/#{id}")
      Rails.cache.delete("entities/rule_members/#{id}")
      Rails.cache.delete("entities/applications/#{id}")
      # entities/members/#{flatten} (can be false or true), we may be storing both
      Rails.cache.delete("entities/members/false/#{id}")
      Rails.cache.delete("entities/members/true/#{id}")
      return true
    else
      logger.debug "Not clearing cache for group #{id}, nothing has changed. Associations may still clear cache."
      return false
    end
  end
end
