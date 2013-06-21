# Group shares many attributes with entity.
class Group < Entity
  using_access_control

  scope :ous, where(Group.arel_table[:code].not_eq(nil))
  scope :non_ous, where(Group.arel_table[:code].eq(nil))

  has_many :memberships, :class_name => "GroupMembership", :dependent => :destroy
  has_many :members, :through => :memberships, :source => :entity
  has_many :role_assignments, :foreign_key => "entity_id", :dependent => :destroy
  has_many :roles, :through => :role_assignments
  has_many :group_ownerships, :dependent => :destroy
  has_many :owners, :through => :group_ownerships, :source => "entity"
  has_many :group_operatorships, :dependent => :destroy
  has_many :operators, :through => :group_operatorships, :source => "entity"
  has_many :rules, :foreign_key => 'group_id', :class_name => "GroupRule", :dependent => :destroy

  validates :name, :presence => true

  attr_accessible :name, :description, :type, :owner_ids, :operator_ids, :rules_attributes, :memberships_attributes

  accepts_nested_attributes_for :rules, :allow_destroy => true
  accepts_nested_attributes_for :memberships, :allow_destroy => true

  after_save :recalculate_members
  after_save :trigger_sync
  
  def as_json(options={})
    { :id => self.id, :name => self.name, :type => 'Group',
      :owners => self.owners.map{ |o| { id: o.id, loginid: o.loginid, name: o.name } },
      :operators => self.operators.map{ |o| { id: o.id, loginid: o.loginid, name: o.name } },
      :memberships => self.memberships.map{ |a| { id: a.id, entity_id: a.entity.id, name: a.entity.name, loginid: a.entity.loginid, calculated: a.calculated } },
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
      destroying_calculated_group_membership do
        memberships.where(:calculated => true).destroy_all
      end

      # Reset calculated group member assignments with the results of this algorithm
      unless results.nil?
        results = results.flatten
        results = results.uniq{ |r| r.id }
        uncalculated_group_member_ids = memberships.where(:calculated => false).map{ |m| m.entity.id }
        results.each do |e|
          m = GroupMembership.new
          m.group_id = id
          m.entity_id = e.id
          m.calculated = true
          m.save
        end
      end
      
      results.nil? ? num_found = 0 : num_found = results.length
      logger.info "Found #{num_found} members, group now has #{memberships.length} total members"
      
      # Force a reload (make sure this function stays as a after_save callback, never before_save)
      # to ensure old memberships get deleted properly. EntityController#update was returning both
      # new calculated memberships _and_ those marked for destruction before this 'reload'
      # statement was added. (Bug in format.json render: json as logger.info @entity.members.length
      # just before the render: json line _does_ show the correct number?)
      reload
    end
  end

  def trigger_sync
    logger.info "Group #{id}: trigger_sync called, calling trigger_sync on #{roles.length} roles"
    roles.all.each { |role| role.trigger_sync }
    return true
  end
end
