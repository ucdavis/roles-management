class Application < ActiveRecord::Base
  has_many :roles
  
  def to_param  # overridden
    name
  end
end
