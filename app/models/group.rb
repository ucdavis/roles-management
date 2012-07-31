class Group < ActiveRecord::Base
  include Uids

  # Group-to-group relationships
  ## Children
  has_many :group_children_assignments
  has_many :children, :through => :group_children_assignments
  ## Parents
  has_many :group_parent_assignment, :class_name => "GroupChildrenAssignment", :foreign_key => "child_id"
  has_many :parents, :through => :group_parent_assignment, :source => :group

  has_and_belongs_to_many :people

  has_many :role_assignments
  has_many :roles, :through => :role_assignments

  has_many :person_owners, :class_name => "Person", :through => :group_owner_assignments, :source => :owner_person
  has_many :group_owners, :class_name => "Group", :through => :group_owner_assignments, :source => :owner_group
  has_many :group_owner_assignments, :dependent => :destroy

  has_many :rules, :foreign_key => 'group_id', :class_name => "GroupRule"

  validates :name, :presence => true

  attr_accessible :name, :people_tokens, :people_ids, :description, :rules_attributes, :owner_tokens, :member_tokens, :owner_ids
  attr_reader :people_tokens

  accepts_nested_attributes_for :rules, :reject_if => lambda { |a| a[:value].blank? || a[:condition].blank? || a[:column].blank? }, :allow_destroy => true

  # Calculates all members, including those defined via rules.
  # If flatten is set to true, child groups are resolved recursively until only a list of people remains.
  # If flatten is false, any member groups will simply be returned as a group (i.e. not as the people _in_ that member group)
  def members(flatten = false)
    members = []

    # Include all people
    people.each do |p|
      members << p
    end

    # Include all children
    children.each do |g|
      if flatten
        g.members(true).each do |p|
          members << p
        end
      else
        members << g
      end
    end

    # Include members via rules
    members += rule_members

    # Only return a unique list
    members.uniq{|x| x.uid}
  end

  def owners
    # Just avoiding the name 'owners' again
    collected_owners = []

    person_owners.each do |p|
      collected_owners << p
    end
    group_owners.each do |g|
      collected_owners << g
    end

    collected_owners
  end

  def owner_ids
    collected_owner_ids = []

    owners.each do |o|
      collected_owner_ids << o.uid
    end

    collected_owner_ids
  end

  # Decodes the fake AR 'owner_ids' and assigned the appropriate objects to
  # person_owners and group_owners
  def owner_ids=(uids)
    self.person_owner_ids = []
    self.group_owner_ids = []

    uids.each do |uid|
      ret = determine_uid(uid)
      if ret[:type] == UID_PERSON
        p = Person.find_by_id(ret[:id])
        person_owners << p unless p.nil? or person_owners.include? p
      elsif ret[:type] == UID_GROUP
        g = Group.find_by_id(ret[:id])
        group_owners << g unless g.nil? or group_owners.include? g
      end
    end
  end

  # An 'OU' is merely a group with a code field set (used to sync with external databases)
  def uid
    if code.nil?
      (UID_GROUP.to_s + id.to_s).to_i
    else
      (UID_OU.to_s + id.to_s).to_i
    end
  end

  # Returns tokenized members, including 'via' parameter to differentiate explicitly-assigned
  # vs. rule-resolved members
  def member_tokens
    result = []
    explicit_members = []
    resolved_members = []

    # Include all people
    people.each do |p|
      explicit_members << p
    end

    # Include all children
    children.each do |g|
      explicit_members << g
    end

    # Include members via rules
    resolved_members += rule_members

    # Unique members only
    explicit_members = explicit_members.uniq{|x| x.uid}
    resolved_members = resolved_members.uniq{|x| x.uid}

    result = explicit_members.map{ |x| { :uid => ('1' + x.id.to_s).to_i, :name => x.name, :readonly => false } }
    result += resolved_members.map{ |x| { :uid => ('1' + x.id.to_s).to_i, :name => x.name, :readonly => true } }

    result
  end

  def owner_tokens
    owner_ids
  end

  # Takes UIDs
  def owner_tokens=(ids)
    self.owner_ids = ids.split(",") #.map{|x| x[1..-1]}
  end

  def people_tokens=(ids)
    self.person_ids = ids.split(",")
  end

  # Takes UIDs
  def member_tokens=(ids)
    # Members can be people or groups, so we have to do some processing
    member_ids = ids.split(",")

    # We'll build these lists and assign them at the end
    p_ids = []
    g_ids = []

    # Determine which members come from rules so we don't add them to the explicit list (causes dupes)
    r_members = []
    rule_members.each do |r|
      r_members += r.map{|x| x.id}
    end

    member_ids.each do |id|
      if(id[0] == '1')
        # Person
        unless r_members.include? id[1..-1].to_i
          p_ids << id[1..-1]
        end
      elsif(id[0] == '2')
        # Group
        g_ids << id[1..-1]
      end
    end

    self.person_ids = p_ids
    self.child_ids = g_ids
  end

  def as_json(options={})
    { :uid => ('2' + self.id.to_s).to_i, :name => self.name, :owners => self.owners, :members => self.member_tokens }
  end

  # Returns all members via resolving group rules
  # This algorithm starts with an empty set, then runs all 'is'
  # rules, intersecting those sets, then makes a second pass and
  # removes anyone who fails a 'is not' rule.
  def rule_members
    results = []

    # Step One: Build groups out of each 'is' rule
    rules.where(:condition => "is").each do |rule|
      results << rule.resolve
    end

    # Step Two: AND all groups from step one together
    result = results.inject(results.first) { |sum,m| sum &= m }

    # Step Three: Pass over the result from step two and
    # remove anybody who violates an 'is not' rule
    if result
      result.find_all{ |member|
        keep = true
        rules.where(:condition => "is not").each do |rule|
          keep &= rule.matches(member)
        end
        keep
      }
    end

    if result.nil?
      return []
    end

    result
  end
end
