class Role < ActiveRecord::Base
  has_many :role_assignments
  has_many :people, :through => :role_assignments
  has_many :groups, :through => :role_assignments
  
  belongs_to :application
end
