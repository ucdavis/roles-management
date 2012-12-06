class Application < ActiveRecord::Base
  using_access_control

  has_many :roles, :dependent => :destroy
  has_many :application_owner_assignments, :dependent => :destroy
  has_many :owners, :through => :application_owner_assignments

  before_save :set_default_properties

  #validate :has_at_least_one_role
  validates :name, :presence => true

  attr_accessible :name, :ous_ids, :hostname, :description, :roles, :roles_attributes, :owner_ids

  belongs_to :api_key

  accepts_nested_attributes_for :roles, :allow_destroy => true

  def self.csv_header
    "Role,ID,Login ID, Email, First, Last".split(',')
  end

  def as_json(options={})
    { :id => self.id, :name => self.name, :roles => self.roles, :description => self.description, :owners => self.owners }
  end

  private

  # Set a few default properties if they're unset
  def set_default_properties
    unless self.description
      self.description = "No description given"
    end
  end

  # def has_at_least_one_role
  #   if self.new_record? # new records get a pass because we can't create a role until the record is at least saved
  #     return true
  #   end
  #   if roles.length > 0
  #     true
  #   else
  #     false
  #   end
  # end
end
