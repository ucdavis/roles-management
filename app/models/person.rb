class Person < ActiveRecord::Base
  versioned
  
  has_and_belongs_to_many :groups
  belongs_to :roles
  
  validates_presence_of :first, :last, :loginid
  
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
