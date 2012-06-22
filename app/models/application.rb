class Application < ActiveRecord::Base
  has_many :roles
  has_many :application_owner_assignments
  has_many :owners, :through => :application_owner_assignments

  after_save :ensure_access_role_exists
  before_save :ensure_api_key_exists, :set_default_properties

  validate :has_at_least_one_role
  validates :name, :presence => true
  
  attr_accessible :name, :ou_tokens, :ous_ids, :hostname, :display_name, :icon, :description, :ad_path, :roles, :roles_attributes, :owner_tokens, :owner_ids
  attr_reader :ou_tokens
  
  accepts_nested_attributes_for :roles, :reject_if => lambda { |a| a[:token].blank? || a[:descriptor].blank? }, :allow_destroy => true
  
  def ou_tokens=(ids)
      self.ou_ids = ids.split(",")
  end
  
  def uid
    (UID_APPLICATION.to_s + id.to_s).to_i
  end

  def owner_tokens
      self.owner_ids
  end

  def owner_tokens=(ids)
      self.owner_ids = ids.split(",").map{|x| x[1..-1]}
  end
  
  def as_json(options={}) 
    { :id => self.id, :name => self.name, :roles => self.roles, :display_name => self.display_name, :uids => self.uids } 
  end
  
  # Returns all UIDs associated with this app (via roles)
  def uids
    uids = []
    
    # People assigned via roles
    uids += roles.collect{ |x| x.people }.flatten.collect { |x| '1' + x.id.to_s }
    
    # Groups assigned via roles
    uids += roles.collect{ |r| r.groups }.flatten.collect{ |g| '2' + g.id.to_s }
    
    # Return without duplicates
    uids.inject([]) { |result,h| result << h unless result.include?(h); result }
  end
  
  private
  
  # All applications must at least have the 'default' access role.
  # If it doesn't exist, create it
  def ensure_access_role_exists
    if roles.find_by_token("access").nil?
      r = Role.new
      r.token = "access"
      r.descriptor = "Access"
      r.description = "Allow access to this application"
      r.default = true
      r.application_id = self.id
      r.save!
      self.roles << r
    end
  end
  
  # Set an API key if one doesn't exist
  def ensure_api_key_exists
    unless self.api_key
      self.api_key = generate_api_key
    end
  end
  
  # Set a few default properties if they're unset
  def set_default_properties
    unless self.display_name
      self.display_name = self.name
    end
    unless self.description
      self.description = "No description given"
    end
  end
  
  # Generates (but does not set) an API key
  # Name and optionally hostname must be set
  def generate_api_key
    if self.hostname.nil?
      hn = ""
    else
      hn = self.hostname
    end
    Digest::MD5.hexdigest(self.name + hn + Time.now.to_i.to_s)
  end
  
  def has_at_least_one_role
    if self.new_record? # new records get a pass because we can't create a role until the record is at least saved
      return true
    end
    if roles.length > 0
      true
    else
      false
    end
  end
end
