class Ou < ActiveRecord::Base
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

  def to_param
    name.gsub("/", "_").gsub("&", "_").gsub(".", "_")
  end
  
  def as_json(options={}) 
    { :id => self.id, :name => self.name } 
  end
end
