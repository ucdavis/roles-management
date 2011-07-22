class Ou < ActiveRecord::Base
  belongs_to :manager, :class_name => "Person"
  
  has_many :ous
end
