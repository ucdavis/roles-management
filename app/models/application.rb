class Application < ActiveRecord::Base
  has_many :roles
  has_many :application_ou_assignments
  has_many :ous, :through => :application_ou_assignments # if empty, application is available to all
  
  attr_accessible :name, :ou_tokens, :ous_ids, :hostname, :display_name
  attr_reader :ou_tokens
  
  def to_param  # overridden
    name
  end
  
  def ou_tokens=(ids)
      self.ou_ids = ids.split(",")
  end
end
