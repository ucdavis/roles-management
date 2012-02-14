class Application < ActiveRecord::Base
  has_many :roles
  has_many :application_ou_assignments
  has_many :ous, :through => :application_ou_assignments
  has_many :application_manager_assignments
  has_many :managers, :through => :application_manager_assignments
  
  has_attached_file :icon, :styles => { :normal => "64x64>", :tiny => "16x16>" }
  
  attr_accessible :name, :ou_tokens, :ous_ids, :hostname, :display_name, :icon, :description, :ad_path, :roles, :roles_attributes
  attr_reader :ou_tokens
  
  accepts_nested_attributes_for :roles, :reject_if => lambda { |a| a[:token].blank? || a[:descriptor].blank? }, :allow_destroy => true
  
  def ou_tokens=(ids)
      self.ou_ids = ids.split(",")
  end
  
  def as_json(options={}) 
    { :id => self.id, :name => self.name, :roles => self.roles } 
  end
  
  # Returns all people associated with any role of this app
  def people
    p = []
    
    # Include explicitly assigned
    p += roles.collect{ |x| x.people }.flatten
    # Include people via groups
    roles.each{ |x| x.groups.each { |y| p += y.members } }
    # Include people via OUs
    
    
    # Return without duplicates
    p.inject([]) { |result,h| result << h unless result.include?(h); result }
  end
end
