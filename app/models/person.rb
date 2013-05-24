# Person shares many attributes with entity.
# Note that the 'name' field is simply self.first + " " + self.last
# and is thus read-only. The same does not apply for groups.
#
# 'roles' refers only to explicit roles. Use method 'all_roles' to include
# those assigned via group membership.
class Person < Entity
  using_access_control

  belongs_to :title
  has_many :affiliation_assignments, :dependent => :destroy
  has_many :affiliations, :through => :affiliation_assignments, :uniq => true

  has_many :group_member_assignments, :foreign_key => "entity_id"
  has_many :group_memberships,
           :through => :group_member_assignments,
           :source => :group,
           :uniq => true

  has_many :role_assignments, :foreign_key => "entity_id", :dependent => :destroy
  has_many :roles, :through => :role_assignments

  has_many :favorite_relationships, :class_name => "PersonFavoriteAssignment", :foreign_key => "owner_id"
  has_many :favorites, :through => :favorite_relationships, :source => :entity

  has_many :application_owner_assignments, :foreign_key => "owner_id", :dependent => :destroy
  has_many :application_ownerships, :through => :application_owner_assignments, :source => :application

  has_many :application_operator_assignments, :foreign_key => "entity_id", :dependent => :destroy
  has_many :application_operatorships, :through => :application_operator_assignments, :source => :application

  has_many :group_operator_assignments, :foreign_key => "entity_id"
  has_many :group_operatorships, :through => :group_operator_assignments, :source => :group

  has_many :group_owner_assignments, :foreign_key => "entity_id"
  has_many :group_ownerships, :through => :group_owner_assignments, :source => :group

  has_one :student

  belongs_to :major

  validates :loginid, :presence => true, :uniqueness => true
  validate :first_or_last_presence

  attr_accessible :first, :last, :loginid, :email, :phone, :address, :type, :role_ids, :favorite_ids, :group_membership_ids, :ou_ids,
                  :group_ownership_ids, :group_operatorship_ids

  after_save :trigger_sync

  def self.csv_header
    "ID,Login ID, Email, First, Last".split(',')
  end
  
  def log_identifier
    loginid
  end

  def to_csv
    [id, loginid, email, first, last]
  end

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

  # Calculates all roles for an individual - explicitly assigned + those via group membership, including group rules
  def all_roles
    computed_roles = []
    computed_roles = roles
    group_memberships.each do |membership|
      computed_roles += membership.roles
    end
    
    computed_roles
  end

  def roles_by_application(application_id)
    Role.includes(:role_assignments).where(:application_id => application_id, :role_assignments => { :entity_id => self.id } ).map{ |x| x.token }
  end

  def roles_by_api_key(api_key_id)
    api_key_role_ids = Application.find_by_api_key_id(api_key_id).roles.map { |x| x.id }
    roles.reject{ |x| ! api_key_role_ids.include? x.id }
  end

  # Overriden to be self.first + " " + self.last
  # though there is a 'name' column used by Entity (for groups).
  # Update first and last, not 'name'. Consider 'name' to be
  # read-only
  def name
    name = ""
    name = first unless first.nil?
    name = name + " " + last unless last.nil?

    return name
  end

  # Compute applications for which they can make assignments.
  # Defined to be all applications for admins, else
  # it is the list of applications they own or can operate.
  def manageable_applications
    apps = []

    # Admins can see all applications
    if is_rm_admin?
      apps = Application.all
    else
      # Add apps where they are owners
      application_ownerships.each do |a|
        apps << a
      end
      # Add apps where they are operators
      application_operatorships.each do |a|
        apps << a
      end
    end

    apps
  end

  # Returns a list of symbols as required by the authorization layer (declarative_authorization gem).
  # Currently only have :access and :admin. Note that an :admin user will have both due to :admin
  # being merely an extension on top of permissions already granted via :access.
  def role_symbols
    syms = []

    roles.where(:id => Application.find_by_name("DSS Roles Management").roles).each do |role|
      syms << role.token.underscore.to_sym
    end

    syms
  end
  
  def as_json(options={})
    { :id => self.id, :name => self.name, :type => 'Person', :email => self.email, :loginid => self.loginid,
      :first => self.first, :last => self.last, :email => self.email, :phone => self.phone, :address => self.address,
      :byline => self.byline,
      :roles => self.all_roles.map{ |r| { id: r.id, token: r.token, name: r.name, description: r.description,
                                          application_name: r.application_name, application_id: r.application_id } },
      :favorites => self.favorites.map{ |f| { id: f.id, name: f.name, type: f.type } },
      :group_memberships => { :non_ous => self.group_memberships.non_ous.map{ |e| { id: e.id, name: e.name, type: e.type } },
                              :ous => self.group_memberships.ous.map{ |e| { id: e.id, name: e.name, type: e.type } } },
      :group_ownerships => self.group_ownerships.map{ |o| { id: o.id, name: o.name, type: o.type } },
      :group_operatorships => self.group_operatorships.map{ |o| { id: o.id, name: o.name, type: o.type } },
      :role_ids => self.role_ids
    }
  end
  
  # Returns true if this user is an admin of "DSS Roles Management" itself
  def is_rm_admin?
    role_symbols.include? :admin
  end

  def trigger_sync
    logger.info "Person #{id}: trigger_sync called, calling trigger_sync on #{roles.length} roles"
    roles.all.each { |role| role.trigger_sync }
    return true
  end
  
  def first_or_last_presence
    unless self.name.length > 0
      errors.add(:name, "first or last must be set")
    end
  end
end
