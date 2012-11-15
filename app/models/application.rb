class Application < ActiveRecord::Base
  using_access_control

  has_many :roles, :dependent => :destroy
  has_many :application_owner_assignments, :dependent => :destroy
  has_many :owners, :through => :application_owner_assignments

  after_save :ensure_access_role_exists
  before_save :set_default_properties

  validate :has_at_least_one_role
  validates :name, :presence => true

  attr_accessible :name, :ous_ids, :hostname, :description, :roles, :roles_attributes, :owners_attributes

  belongs_to :api_key

  accepts_nested_attributes_for :roles, :reject_if => lambda { |a| a[:token].blank? || a[:descriptor].blank? }, :allow_destroy => true

  def self.csv_header
    "Role,ID,Login ID, Email, First, Last".split(',')
  end

  def as_json(options={})
    { :id => self.id, :name => self.name, :roles => self.roles, :description => self.description, :owners => self.owners }
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

  # Set a few default properties if they're unset
  def set_default_properties
    unless self.description
      self.description = "No description given"
    end
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
