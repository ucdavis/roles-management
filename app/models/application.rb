class Application < ActiveRecord::Base
  has_many :roles
  has_many :application_ou_assignments
  has_many :ous, :through => :application_ou_assignments # if empty, application is available to all
  
  def to_param  # overridden
    name
  end
end
