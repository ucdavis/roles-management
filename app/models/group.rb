class Group < ActiveRecord::Base
  has_and_belongs_to_many :groups,
                          :join_table => "group_group",
                          :foreign_key => "group_id",
                          :association_foreign_key => "subgroup_id"
  
  has_and_belongs_to_many :people
  
  has_many :role_assignments
  has_many :roles, :through => :role_assignments
  
  belongs_to :owner, :class_name => "Person"
  
  attr_accessible :name, :people_tokens, :people_ids, :description
  attr_reader :people_tokens
  
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
