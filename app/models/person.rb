class Person < ActiveRecord::Base
  versioned
  
  has_and_belongs_to_many :groups
  has_many :role_assignments
  has_many :roles, :through => :role_assignments
  
  has_many :ous, :through => :ou_assignments
  has_many :ou_assignments

  has_many :ou_manager_assignments
  has_many :managements, :through => :ou_manager_assignments, :source => :ou, :primary_key => "manager_id"
  
  validates_presence_of :loginid #:first, :last
  
  def to_param  # overridden
    loginid
  end
  
  def name
      "#{first} #{last}"
  end
  
  def as_json(options={}) 
      { :id => self.id, :name => self.first + " " + self.last } 
  end
end
