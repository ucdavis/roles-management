class Ou < ActiveRecord::Base
  has_many :managers, :class_name => "Person", :through => :ou_manager_assignments
  has_many :ou_manager_assignments
  
  has_many :ous

  def to_param  # overridden
    name.gsub("/", "_").gsub("&", "_").gsub(".", "_")
  end
end
