class Ou < ActiveRecord::Base
  validates :parent_ids, :length => { :maximum => 1, :message => "Cannot have more than one parent." }
  
  # Manager (a person) relationship
  has_many :managers, :class_name => "Person", :through => :ou_manager_assignments
  has_many :ou_manager_assignments
  
  # Ou-to-ou relationships
  ## Children
  has_many :ou_children_assignments
  has_many :children, :through => :ou_children_assignments
  ## Parents
  has_many :ou_parent_assignment, :class_name => "OuChildrenAssignment", :foreign_key => "child_id"
  has_many :parents, :through => :ou_parent_assignment, :source => :ou
  
  # Ou-to-application relationships
  has_many :application_ou_assignments
  has_many :applications, :through => :application_ou_assignments
  
  # Ou-to-members (people, not managers) relationship
  has_many :members, :through => :ou_assignments, :source => :person
  has_many :ou_assignments

  attr_accessible :name, :parent_tokens, :parent_ids
  attr_reader :parent_tokens

  def to_param
    name.gsub("/", "_").gsub("&", "_").gsub(".", "_")
  end
  
  def as_json(options={}) 
    { :id => self.id, :name => self.name } 
  end
  
  def self.top_level
    self.all.reject{ |c| c.parents.empty? == false }
  end
  
  def parent_tokens=(ids)
      self.parent_ids = ids.split(",")
  end
end
