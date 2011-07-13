class Person < ActiveRecord::Base
  versioned
  
  has_and_belongs_to_many :groups
  belongs_to :title
  belongs_to :affiliation
  
  #belongs_to :assignment, :as => :assignable
  
  validates_presence_of :first, :last, :loginid
  
  def to_param  # overridden
    loginid
  end
  
  def name
      "#{first} #{last}"
  end
end
