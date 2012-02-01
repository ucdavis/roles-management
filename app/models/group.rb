class Group < ActiveRecord::Base
  has_and_belongs_to_many :groups,
                          :join_table => "group_group",
                          :foreign_key => "group_id",
                          :association_foreign_key => "subgroup_id"
  
  has_and_belongs_to_many :people
  
  has_many :role_assignments
  has_many :roles, :through => :role_assignments
  
  has_many :owners, :class_name => "Person", :through => :group_owner_assignments
  has_many :group_owner_assignments, :dependent => :destroy
  
  has_many :rules, :foreign_key => 'group_id', :class_name => "GroupRule"
  
  attr_accessible :name, :people_tokens, :people_ids, :description, :rules_attributes, :owner_tokens, :member_tokens
  attr_reader :people_tokens
  
  accepts_nested_attributes_for :rules, :reject_if => lambda { |a| a[:value].blank? || a[:condition].blank? || a[:column].blank? }, :allow_destroy => true
  
  # Calculates all members (people), including those defined via rules.
  def members
    members = []
    
    # Include all people
    people.each do |p|
      members << p
    end
    
    # Include all groups
    groups.each do |g|
      members << g
    end
    
    # Include members via rules
    rules.each do |r|
      members += r.resolve
    end
    
    members
  end
  
  def owner_tokens
    owner_ids
  end
  
  # Takes UIDs
  def owner_tokens=(ids)
    self.owner_ids = ids.split(",").map{|x| x[1..-1]}
  end

  def people_tokens=(ids)
    self.person_ids = ids.split(",")
  end
  
  def member_tokens
    members.map{ |x| { :id => ('1' + x.id.to_s).to_i, :name => x.name } }
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
    rules.each do |r|
      r_members += r.resolve.map{|x| x.id}
    end
    
    logger.info "r_members is " + r_members.to_s
    
    member_ids.each do |id|
      if(id[0] == '1')
        # Person
        unless r_members.include? id[1..-1].to_i
          logger.info "adding to p_id: " + id[1..-1].to_s
          p_ids << id[1..-1]
        end
      elsif(id[0] == '2')
        # Group
        g_ids << id[1..-1]
      end
    end
    
    self.person_ids = p_ids
    self.group_ids = g_ids
  end
  
  def as_json(options={}) 
    { :id => ('2' + self.id.to_s).to_i, :name => self.name } 
  end
end
