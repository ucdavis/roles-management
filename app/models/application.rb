class Application < ActiveRecord::Base
  using_access_control

  has_many :roles, :dependent => :destroy
  has_many :application_owner_assignments, :dependent => :destroy
  has_many :owners, :through => :application_owner_assignments
  has_many :application_operator_assignments
  has_many :operators, :through => :application_operator_assignments, :source => "entity", :dependent => :destroy

  before_save :set_default_properties

  validates :name, :presence => true

  attr_accessible :name, :ous_ids, :hostname, :description, :roles, :roles_attributes, :owner_ids, :operator_ids

  belongs_to :api_key

  accepts_nested_attributes_for :roles, :allow_destroy => true

  def self.csv_header
    "Role,ID,Login ID, Email, First, Last".split(',')
  end

  def as_json(options={})
    { :id => self.id, :name => self.name, :roles => self.roles, :description => self.description, :owners => self.owners, :operators => self.operators }
  end

  # Overriden to avoid having to use _destroy in Backbone/simplify client-side interaction
  def roles_attributes=(role_attrs)
    ids_touched = [] # We'll remove any roles that weren't touched at the end

    unless role_attrs.nil?
      # Add/update roles
      role_attrs.each do |role|
        logger.info role
        if (role[:id].to_s)[0..3] == "new_"
          # New role
          r = Role.new
          r.token = role[:token]
          r.name = role[:name]
          r.description = role[:description]
          r.entity_ids = role[:entity_ids]
          r.ad_path = role[:ad_path]
          r.application_id = id
          r.save
          ids_touched << r.id
        else
          # Updating a role
          r = Role.find(role[:id])
          r.token = role[:token]
          r.name = role[:name]
          r.description = role[:description]
          r.entity_ids = role[:entity_ids]
          r.ad_path = role[:ad_path]
          r.save
          ids_touched << r.id
        end
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
