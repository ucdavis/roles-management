class Group < ActiveRecord::Base
  has_and_belongs_to_many :groups,
                          :join_table => "group_group",
                          :foreign_key => "group_id",
                          :association_foreign_key => "subgroup_id"
  
  has_and_belongs_to_many :people
  
  has_many :role_assignments
  has_many :roles, :through => :role_assignments
  
  has_many :owners, :class_name => "Person", :through => :group_owner_assignments
  has_many :group_owner_assignments
  
  has_many :rules, :foreign_key => 'group_id', :class_name => "GroupRule"
  
  attr_accessible :name, :people_tokens, :people_ids, :description
  attr_reader :people_tokens
  
  # Calculates all members (people and groups), including those defined via rules.
  # Uses UID ID numbers (see README)
  def members
    members = []
    
    # Include all people
    people.each do |p|
      members += [['1' + p.id.to_s, p.name ]]
    end
    
    # Include all groups
    groups.each do |g|
      members << {:id => ('2' + g.id.to_s).to_i, :name => g.name }
    end
    
    # Include members via rules
    rules.each do |r|
      members += r.resolve
    end
    
    members
  end
  
  def people_tokens=(ids)
      self.person_ids = ids.split(",")
  end
  
  def to_param  # overridden
    name.gsub("/", "_").gsub("&", "_").gsub(".", "_")
  end
  
  def as_json(options={}) 
    { :id => self.id, :name => self.name } 
  end
end
