class Group < ActiveRecord::Base
  has_and_belongs_to_many :people
  
  has_many :assignments, :as => :assignable
  
  belongs_to :manager, :class_name => "Person"
  belongs_to :head, :class_name => "Person"
  
  def to_param  # overridden
    name.gsub("/", "_").gsub("&", "_").gsub(".", "_")
  end
end
