class Application < ActiveRecord::Base
  using_access_control

  has_many :roles, :dependent => :destroy
  has_many :application_ownerships, :dependent => :destroy
  has_many :owners, :through => :application_ownerships
  has_many :application_operatorships, :dependent => :destroy
  has_many :operators, :through => :application_operatorships, :source => "entity", :dependent => :destroy
  belongs_to :api_key

  validates :name, :presence => true, :uniqueness => true

  attr_accessible :name, :ous_ids, :hostname, :description, :roles, :roles_attributes, :owner_ids, :operator_ids

  accepts_nested_attributes_for :roles, :allow_destroy => true

  before_save :set_default_properties

  def as_json(options={})
    { :id => self.id, :name => self.name,
      :roles => self.roles.map{ |r| { id: r.id, description: r.description, token: r.token, name: r.name,
                                      entities: r.entities.map { |e| { id: e.id, name: e.name, type: e.type } },
                                      members: r.members.map { |m| { id: m.id, name: m.name, loginid: m.loginid } },
                                      ad_path: r.ad_path } },
      :description => self.description, :owners => self.owners.map{ |o| { name: o.name, id: o.id } },
      :operators => self.operators.map{ |o| { name: o.name, id: o.id } } }
  end

  def self.csv_header
    "Role,ID,Login ID,Email,First,Last".split(',')
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
