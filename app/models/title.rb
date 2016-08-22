class Title < ActiveRecord::Base
  has_and_belongs_to_many :classifications
  has_many :people

  # We no longer require a title name so that we can import
  # new titles from LDAP based on code. LDAP does not
  # have a reliable title name for each code however as
  # a person may set a custom title in LDAP.
  #validates :name, :presence => true
  validates :code, :presence => true, :uniqueness => true

  def as_json(options={})
      { :id => self.id, :name => self.name, :code => self.code }
  end
end
