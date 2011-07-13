class Group < ActiveRecord::Base
  has_and_belongs_to_many :people
  
  has_many :assignments, :as => :assignable
  
  def to_param  # overridden
    name.gsub("/", "_").gsub("&", "_").gsub(".", "_")
  end
end
