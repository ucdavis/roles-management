class Application < ActiveRecord::Base
  has_many :roles
  has_many :application_ou_assignments
  has_many :ous, :through => :application_ou_assignments # if empty, application is available to all
  
  has_attached_file :icon, :styles => { :normal => "64x64>", :tiny => "16x16>" }
  
  attr_accessible :name, :ou_tokens, :ous_ids, :hostname, :display_name, :icon, :description
  attr_reader :ou_tokens
  
  def ou_tokens=(ids)
      self.ou_ids = ids.split(",")
  end
  
  def as_json(options={}) 
    { :id => self.id, :name => self.name, :roles => self.roles } 
  end
end
