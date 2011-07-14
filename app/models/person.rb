class Person < ActiveRecord::Base
  versioned
  
  has_and_belongs_to_many :groups
  belongs_to :title
  belongs_to :affiliation
  
  has_many :managements, :class_name => "Group", :foreign_key => "manager_id"
  has_many :heads, :class_name => "Group", :foreign_key => "head_id"
  
  #belongs_to :assignment, :as => :assignable
  
  validates_presence_of :first, :last, :loginid
  
  def to_param  # overridden
    loginid
  end
  
  def name
      "#{first} #{last}"
  end
end
