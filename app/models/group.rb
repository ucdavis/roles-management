class Group < Entity
  using_access_control

  scope :ous, where(Group.arel_table[:code].not_eq(nil))
  scope :non_ous, where(Group.arel_table[:code].eq(nil))

  has_many :group_memberships
  has_many :members, :through => :group_memberships, :source => :entity

  has_many :role_assignments, :foreign_key => "entity_id"
  has_many :roles, :through => :role_assignments, :dependent => :destroy

  has_many :group_ownerships
  has_many :owners, :through => :group_ownerships, :dependent => :destroy, :source => "entity"

  has_many :group_operatorships
  has_many :operators, :through => :group_operatorships, :dependent => :destroy, :source => "entity"

  has_many :rules, :foreign_key => 'group_id', :class_name => "GroupRule", :dependent => :destroy

  validates :name, :presence => true

  attr_accessible :name, :description, :type, :explicit_member_ids, :owner_ids, :operator_ids, :rules_attributes

  accepts_nested_attributes_for :rules,
                                :reject_if => lambda { |a| a[:value].blank? || a[:condition].blank? || a[:column].blank? },
                                :allow_destroy => true

  after_save :trigger_sync
  
  def as_json(options={})
    { :id => self.id, :name => self.name, :type => 'Group',
      :owners => self.owners.map{ |o| { id: o.id, loginid: o.loginid, name: o.name } },
      :operators => self.operators.map{ |o| { id: o.id, loginid: o.loginid, name: o.name } },
      :memberships => self.group_memberships.map{ |a| { id: a.id, member_id: a.entity.id, name: a.entity.name, loginid: a.entity.loginid, calculated: a.calculated } },
      :rules => self.rules.map{ |r| { id: r.id, column: r.column, condition: r.condition, value: r.value } } }
  end
  
  def ou?
    code != nil
  end

  # Returns all members, both explicitly assigned and calculated via rules.
  # Recurses groups all the way down to return a list of _only_people_.
  def flattened_members
    results = []

    members.all.each do |e|
      if e.type == "Group"
        e.flattened_members.each do |m|
          members << m
        end
      else
        members << e
      end
    end

    # Only return a unique list
    results.uniq{ |x| x.id }
  end

  # Overriden to avoid having to use _destroy in Backbone/simplify client-side interaction
  def rules_attributes=(rule_attrs)
    ids_touched = [] # We'll remove any rules that weren't touched at the end

    # Add/update rules
    unless rule_attrs.nil?
      rule_attrs.each do |rule|
        if rule[:id] == nil
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
    
    recalculate_members
  end

  # Compute accessible applications
  def applications
    apps = []

    # Add apps via roles explicitly assigned
    roles.each { |role| apps << role.application }

    apps
  end
  
  # Calculates (and resets) all group_members based on rules.
  # Will delete any *_member_assignment flagged as calculated and rebuild
  # from rules.
  # This algorithm starts with an empty set, then runs all 'is'
  # rules, intersecting those sets, then makes a second pass and
  # removes anyone who fails a 'is not' rule.
  def recalculate_members
    Rails.logger.tagged "Group #{id}" do
      results = []
      
      logger.info "Recalculating members..."

      # Step One: Build groups out of each 'is' rule,
      #           groupping rules of similar type together via OR
      #           Note: we ignore the 'loginid' column as it is calculated separately
      rules.where(:condition => "is").where(:column => GroupRule.valid_columns.reject{|x| x == "loginid"}).all.group_by(&:column).each do |ruleset|
        ruleset_results = []

        ruleset[1].each do |rule|
          ruleset_results << rule.resolve
        end

        results << ruleset_results.inject(ruleset_results.first) { |sum,m| sum |= m }
      end

      # Step Two: AND all groups from step one together
      results = results.inject(results.first) { |sum,m| sum &= m }

      if results
        # Step Three: Pass over the result from step two and
        # remove anybody who violates an 'is not' rule
        results = results.find_all{ |member|
          keep = true
          rules.where(:condition => "is not").all.each do |rule|
            keep &= rule.matches(member)
          end
          keep
        }
      end
      
      # Step Four: Process any 'loginid is' rules
      rules.where({:condition => "is", :column => "loginid"}).all.each do |rule|
        if results.nil?
          results = []
        end
        results << rule.resolve.at(0)
      end

      # Remove previous calculated group member assignments
      calculated_members.destroy_all

      # Reset calculated group member assignments with the results of this algorithm
      unless results.nil?
        results = results.flatten
        results = results.uniq{ |r| r.id }
        self.calculated_member_ids = results.map{ |m| m.id }
      end
      
      results.nil? ? num_found = 0 : num_found = results.length
      logger.info "Found #{num_found} members"
    end
  end

  def trigger_sync
    logger.info "Group #{id}: trigger_sync called, calling trigger_sync on #{roles.length} roles"
    roles.all.each { |role| role.trigger_sync }
    return true
  end
end
