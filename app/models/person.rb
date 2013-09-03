# Person shares many attributes with entity.
# Note that the 'name' field is simply self.first + " " + self.last
# and is thus read-only. The same does not apply for groups.
class Person < Entity
  using_access_control

  has_many :affiliation_assignments, :dependent => :destroy
  has_many :affiliations, :through => :affiliation_assignments, :uniq => true
  has_many :group_memberships, :foreign_key => "entity_id"
  has_many :groups, :through => :group_memberships, :source => :group
  has_many :role_assignments, :foreign_key => "entity_id", :dependent => :destroy
  has_many :roles, :through => :role_assignments, :source => :role
  has_many :favorite_relationships, :class_name => "PersonFavoriteAssignment", :foreign_key => "owner_id"
  has_many :favorites, :through => :favorite_relationships, :source => :entity
  has_many :application_ownerships, :foreign_key => "owner_id", :dependent => :destroy
  has_many :application_operatorships, :foreign_key => "entity_id", :dependent => :destroy
  has_many :group_operatorships, :foreign_key => "entity_id"
  has_many :group_ownerships, :foreign_key => "entity_id"
  has_one :student
  belongs_to :title
  belongs_to :major
  
  accepts_nested_attributes_for :group_ownerships, :allow_destroy => true
  accepts_nested_attributes_for :group_operatorships, :allow_destroy => true
  accepts_nested_attributes_for :group_memberships, :allow_destroy => true
  accepts_nested_attributes_for :role_assignments, :allow_destroy => true

  validates :loginid, :presence => true, :uniqueness => true
  validate :first_or_last_presence

  attr_accessible :first, :last, :loginid, :email, :phone, :address, :type, :favorite_ids, :group_memberships_attributes, :group_ownerships_attributes, :group_operatorships_attributes, :role_assignments_attributes

  before_save :ensure_name_exists
  after_save :trigger_sync

  def as_json(options={})
    { :id => self.id, :name => self.name, :type => 'Person', :email => self.email, :loginid => self.loginid, :first => self.first,
      :last => self.last, :email => self.email, :phone => self.phone, :address => self.address, :byline => self.byline,
      :role_assignments => self.role_assignments.includes(:role).map{ |a| { id: a.id, calculated: a.parent_id?, entity_id: a.entity_id,
                                                            role_id: a.role.id, token: a.role.token, application_name: a.role.application.name,
                                                            application_id: a.role.application_id, name: a.role.name, description: a.role.description } },
      :favorites => self.favorites.map{ |f| { id: f.id, name: f.name, type: f.type } },
      :group_memberships => self.group_memberships.includes(:group).map{ |m| { id: m.id, group_id: m.group.id, name: m.group.name, ou: m.group.ou?, calculated: m.calculated } },
      :group_ownerships => self.group_ownerships.includes(:group).map{ |o| { id: o.id, group_id: o.group.id, name: o.group.name } },
      :group_operatorships => self.group_operatorships.includes(:group).map{ |o| { id: o.id, group_id: o.group.id, name: o.group.name } }
    }
  end

  # For CSV export
  def self.csv_header
    "ID,Login ID, Email, First, Last".split(',')
  end
  def to_csv
    [id, loginid, email, first, last]
  end
  
  # Returns identifying string for logging purposes. Other classes implement this method too.
  def log_identifier
    loginid
  end

  # Calculates 'byline' for a Person, e.g. "PROGRAMMER V (staff:career)"
  def byline
    if title and title.name
      byline = title.name
    else
      byline = ""
    end
    byline += " (" + affiliations.map{ |x| x.name }.join(", ") + ")" if affiliations.count > 0
    byline
  end

  # Compute their classifications based on their title
  def classifications
    title.classifications
  end

  # Returns a list of symbols as required by the authorization layer (declarative_authorization gem).
  # Currently only have :access and :admin. Note that an :admin user will have both due to :admin
  # being merely an extension on top of permissions already granted via :access.
  def role_symbols
    syms = []

    roles.select{ |r| rm_roles_ids.include? r.id }.each do |r|
      syms << r.token.underscore.to_sym
    end

    syms
  end
  
  def trigger_sync
    logger.info "Person #{id}: trigger_sync called, calling trigger_sync on #{roles.length} roles"
    roles.all.each { |role| role.trigger_sync }
    return true
  end

  private
  def ensure_name_exists
    if self.name.nil?
      self.name = ""
      self.name = self.first unless self.first.nil?
      self.name = self.name + " " + self.last unless self.last.nil?
    end
  end
  
  # Validators.
  def first_or_last_presence
    unless self.name.length > 0
      errors.add(:name, "first or last must be set")
    end
  end
end
