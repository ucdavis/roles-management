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
  
  attr_accessible :name, :people_tokens, :people_ids, :description, :rules_attributes, :owner_tokens
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
  
  def owner_tokens=(ids)
    self.owner_ids = ids.split(",")
  end

  def people_tokens=(ids)
    self.person_ids = ids.split(",")
  end
  
  def member_tokens
    members.map{ |x| { :id => ('1' + x.id.to_s).to_i, :name => x.name } }
  end
  
  def as_json(options={}) 
    { :id => ('2' + self.id.to_s).to_i, :name => self.name } 
  end
end
