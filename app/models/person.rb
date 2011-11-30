class Person < ActiveRecord::Base
  versioned
  
  belongs_to :title
  has_many :affiliation_assignments
  has_many :affiliations, :through => :affiliation_assignments
  
  has_and_belongs_to_many :groups
  has_many :role_assignments
  has_many :roles, :through => :role_assignments
  
  has_many :ous, :through => :ou_assignments
  has_many :ou_assignments

  has_many :ou_manager_assignments
  has_many :managements, :through => :ou_manager_assignments, :source => :ou, :primary_key => "manager_id"

  has_many :group_manager_assignments
  has_many :ownerships, :through => :group_manager_assignments, :source => :group, :primary_key => "owner_id"
  
  validates_presence_of :loginid
  
  attr_accessible :first, :last, :loginid, :email, :phone, :status, :address, :preferred_name, :ou_tokens, :ou_ids, :group_tokens, :group_ids
  attr_reader :ou_tokens, :group_tokens
  
  def to_param  # overridden
    loginid
  end
  
  def name
      "#{first} #{last}"
  end
  
  # Compute their classifications based on their title
  def classifications
    title.classifications
  end
  
  def as_json(options={}) 
      { :id => self.id, :name => self.first + " " + self.last } 
  end
  
  # ACL symbols
  def role_symbols
    # Get this app's API key
    api_key = YAML.load_file("#{Rails.root.to_s}/config/api_keys.yml")['keys']['key']
    
    syms = []
    
    # Query for permissions of user via API key, converting them into declarative_authentication's needed symbols
    roles.includes("application").where(:applications => {:api_key => api_key}).each do |role|
      syms << role.name.underscore.to_sym
    end
    
    syms
  end
  
  def ou_tokens=(ids)
      self.ou_ids = ids.split(",")
  end

  def group_tokens=(ids)
      self.group_ids = ids.split(",")
  end
end
