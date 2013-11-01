# Group shares many attributes with entity.
class Group < Entity
  using_access_control

  scope :ous, where(Group.arel_table[:code].not_eq(nil))
  scope :non_ous, where(Group.arel_table[:code].eq(nil))

  has_many :memberships, :class_name => "GroupMembership", :dependent => :destroy
  has_many :members, :through => :memberships, :source => :entity
  has_many :role_assignments, :foreign_key => "entity_id", :dependent => :destroy
  has_many :roles, :through => :role_assignments, :dependent => :destroy
  has_many :group_ownerships, :dependent => :destroy
  has_many :owners, :through => :group_ownerships, :source => "entity", :dependent => :destroy
  has_many :application_ownerships, :foreign_key => "entity_id", :dependent => :destroy
  has_many :application_operatorships, :foreign_key => "entity_id", :dependent => :destroy
  has_many :group_operatorships, :dependent => :destroy
  has_many :operators, :through => :group_operatorships, :source => "entity", :dependent => :destroy
  has_many :rules, :foreign_key => 'group_id', :class_name => "GroupRule", :dependent => :destroy

  validates_presence_of :name

  attr_accessible :name, :description, :type, :owner_ids, :operator_ids, :rules_attributes, :memberships_attributes

  accepts_nested_attributes_for :rules, :allow_destroy => true
  accepts_nested_attributes_for :memberships, :allow_destroy => true

  after_save :recalculate_members!
  
  def as_json(options={})
    { :id => self.id, :name => self.name, :type => 'Group', :description => self.description,
      :owners => self.owners.map{ |o| { id: o.id, loginid: o.loginid, name: o.name } },
      :operators => self.operators.map{ |o| { id: o.id, loginid: o.loginid, name: o.name } },
      :memberships => self.memberships.includes(:entity).map{ |m| { id: m.id, entity_id: m.entity.id, name: m.entity.name, loginid: m.entity.loginid, calculated: m.calculated } },
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
          results << m
        end
      else
        results << e
      end
    end

    # Only return a unique list
    results.uniq{ |x| x.id }
  end

  # Calculates (and resets) all group_members based on rules.
  # Will delete any *_member_assignment flagged as calculated and rebuild
  # from rules.
  # This algorithm starts with an empty set, then runs all 'is'
  # rules, intersecting those sets, then makes a second pass and
  # removes anyone who fails a 'is not' rule.
  def recalculate_members!
    Rails.logger.tagged "Group #{id}" do
      results = []
      
      recalculate_start = Time.now
      
      logger.info "Reassembling group members using rule result cache ..."

      # Step One: Build groups out of each 'is' rule,
      #           groupping rules of similar type together via OR
      #           Note: we ignore the 'loginid' column as it is calculated separately
      rules.select{ |r| r.condition == "is" and GroupRule.valid_columns.reject{|x| x == "loginid"}.include? r.column }.group_by(&:column).each do |ruleset|
        ruleset_results = []

        ruleset[1].each do |rule|
          logger.info "Rule (#{rule.id}, #{rule.column} #{rule.condition} #{rule.value}) has #{rule.results.length} result(s)"
          ruleset_results << rule.results.map{ |r| r.entity_id }
        end
        
        results << ruleset_results.reduce(:+)
      end

      # Step Two: AND all groups from step one together
      results = results.inject(results.first) { |sum,n| sum &= n }
      results = [] unless results # reduce/inject may return nil

      if results
        # Step Three: Pass over the result from step two and
        # remove anybody who violates an 'is not' rule
        results = results.find_all{ |member|
          keep = true
          rules.select{ |r| r.condition == "is not" }.each do |rule|
            keep &= rule.matches(member)
          end
          keep
        }
      end
      
      # Step Four: Process any 'loginid is' rules
      rules.select{ |r| r.condition == "is" and r.column == "loginid" }.each do |rule|
        logger.info "Processing loginid is rule #{rule.value}..."
        results << rule.results.map{ |r| r.entity_id }
      end
      
      results.flatten!

      # Ensure the mass GroupMembership creation (and subsequent mass RoleAssignment creation)
      # doesn't trigger a flurry of trigger_sync - we can intelligently do this group's roles
      # after the new RoleAssignments are created.
      Thread.current[:will_sync_role] = [] unless Thread.current[:will_sync_role]
      roles.each do |r|
        Thread.current[:will_sync_role] << r.id
        logger.debug "Locking role #{r.id} against syncing - we will call trigger_sync! after recalculation."
      end

      # Remove previous calculated group member assignments
      GroupMembership.destroying_calculated_group_membership do
        GroupMembership.recalculating_membership do
          GroupMembership.where(:group_id => self.id, :calculated => true).destroy_all
        end
      end

      # Reset calculated group member assignments with the results of this algorithm
      if results
        results.each do |r|
          GroupMembership.recalculating_membership do
            memberships << GroupMembership.new(:entity_id => r, :calculated => true)
          end
        end
      end
      
      logger.info "Calculated #{results.length} results. Membership now at #{memberships.length} members. Took #{Time.now - recalculate_start}s."
      
      # As promised, now that all the GroupMembership and RoleAssignment objects are created,
      # we will sync roles in one sweep instead of allowing the flurry of activity to create
      # chaotic redundancies with trigger_sync.
      roles.each do |r|
        Thread.current[:will_sync_role].delete(r.id)
        logger.debug "Unlocking role #{r.id} for syncing and calling trigger_sync!."
        r.trigger_sync!
      end
      
      logger.info "Completed recalculate_members!, including role trigger syncs. Total elapsed time was #{Time.now - recalculate_start}s."
    end
  end

  def trigger_sync
    logger.info "Group #{id}: trigger_sync called, calling trigger_sync on #{roles.length} roles"
    roles.all.each { |role| role.trigger_sync! }
  end
end
