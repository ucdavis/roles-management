class Ou < ActiveRecord::Base
  belongs_to :manager, :class_name => "Person"
  
  has_many :ous

  def to_param  # overridden
    name.gsub("/", "_").gsub("&", "_").gsub(".", "_")
  end
end
