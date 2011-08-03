class Role < ActiveRecord::Base
  has_many :role_assignments
  has_many :people, :through => :role_assignments
  has_many :groups, :through => :role_assignments
  
  belongs_to :application
  
  attr_accessible :name, :people_tokens, :people_ids
  attr_reader :people_tokens
  
  def people_tokens=(ids)
      self.person_ids = ids.split(",")
  end
end
