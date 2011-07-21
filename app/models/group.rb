class Group < ActiveRecord::Base
  has_and_belongs_to_many :people
  belongs_to :roles
  
  def to_param  # overridden
    name.gsub("/", "_").gsub("&", "_").gsub(".", "_")
  end
end
