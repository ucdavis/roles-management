class Group < ActiveRecord::Base
  has_and_belongs_to_many :people
  
  def to_param  # overridden
    name.gsub("/", "_").gsub("&", "_").gsub(".", "_")
  end
end
