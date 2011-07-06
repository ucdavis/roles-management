class Person < ActiveRecord::Base
  versioned
  
  validates_presence_of :first, :last, :loginid
  
  def name
      "#{first} #{last}"
  end
end
