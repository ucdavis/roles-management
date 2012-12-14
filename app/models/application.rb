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

  # Overriden to avoid having to use _destroy in Backbone/simplify client-side interaction
  def roles_attributes=(role_attrs)
    ids_touched = [] # We'll remove any roles that weren't touched at the end

    # Add/update roles
    role_attrs.each do |role|
      logger.info role
      if (role[:id].to_s)[0..3] == "new_"
        # New role
        r = Role.new
        r.token = role[:token]
        r.default = role[:default]
        r.descriptor = role[:descriptor]
        r.description = role[:description]
        r.entity_ids = role[:entity_ids]
        r.application_id = id
        r.save
        ids_touched << r.id
      else
        # Updating a role
        r = Role.find(role[:id])
        r.token = role[:token]
        r.default = role[:default]
        r.descriptor = role[:descriptor]
        r.description = role[:description]
        r.entity_ids = role[:entity_ids]
        r.save
        ids_touched << r.id
      end
    end

    # Remove unnecessary ones
    roles.all.each do |r|
      unless ids_touched.include? r.id
        r.destroy
      end
    end
  end

  private

  # Set a few default properties if they're unset
  def set_default_properties
    unless self.description
      self.description = "No description given"
    end
  end
end
