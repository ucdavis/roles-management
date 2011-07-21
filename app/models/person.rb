class Person < ActiveRecord::Base
  versioned
  
  has_and_belongs_to_many :groups
  
  validates_presence_of :first, :last, :loginid
  
  def to_param  # overridden
    loginid
  end
  
  def name
      "#{first} #{last}"
  end
end
