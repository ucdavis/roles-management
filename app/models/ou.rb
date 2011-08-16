class Ou < ActiveRecord::Base
  has_many :managers, :class_name => "Person", :through => :ou_manager_assignments
  has_many :ou_manager_assignments
  
  has_many :ous
  
  has_many :application_ou_assignments
  has_many :applications, :through => :application_ou_assignments
  
  has_many :members, :through => :ou_assignments, :source => :person
  has_many :ou_assignments

  def to_param  # overridden
    name.gsub("/", "_").gsub("&", "_").gsub(".", "_")
  end
  
  def as_json(options={}) 
    { :id => self.id, :name => self.name } 
  end
end
