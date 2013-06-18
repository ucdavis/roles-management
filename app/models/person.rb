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

  # explicit - they were directly assigned to that group
  # calculated - they are in the group because they match a group rule
  has_many :group_explicit_member_assignments, :foreign_key => "entity_id"
  has_many :explicit_groups, :through => :group_explicit_member_assignments, :source => :group
  has_many :group_calculated_member_assignments, :foreign_key => "entity_id"
  has_many :calculated_groups, :through => :group_calculated_member_assignments, :source => :group

  has_many :role_assignments, :foreign_key => "entity_id", :dependent => :destroy
  has_many :explicit_roles, :through => :role_assignments, :source => :role

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

  attr_accessible :first, :last, :loginid, :email, :phone, :address, :type, :explicit_role_ids, :favorite_ids, :explicit_group_ids, :ou_ids, :group_ownership_ids, :group_operatorship_ids

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
    all_roles = explicit_roles.map { |r| { id: r.id, token: r.token, application_name: r.application.name, application_id: r.application_id, name: r.name, description: r.description, ad_path: r.ad_path, explicit: true } }

    explicit_groups.each do |group|
      all_roles += group.roles.map { |r| { id: r.id, token: r.token, application_name: r.application.name, application_id: r.application_id, name: r.name, description: r.description, ad_path: r.ad_path, explicit: false } }
    end
    calculated_groups.each do |group|
      all_roles += group.roles.map { |r| { id: r.id, token: r.token, application_name: r.application.name, application_id: r.application_id, name: r.name, description: r.description, ad_path: r.ad_path, explicit: false } }
    end
    
    all_roles
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

  # Returns a list of symbols as required by the authorization layer (declarative_authorization gem).
  # Currently only have :access and :admin. Note that an :admin user will have both due to :admin
  # being merely an extension on top of permissions already granted via :access.
  def role_symbols
    syms = []

    explicit_roles.where(:id => Application.find_by_name("DSS Roles Management").roles).each do |role|
      syms << role.token.underscore.to_sym
    end

    syms
  end
  
  def as_json(options={})
    { :id => self.id, :name => self.name, :type => 'Person', :email => self.email, :loginid => self.loginid,
      :first => self.first, :last => self.last, :email => self.email, :phone => self.phone, :address => self.address,
      :byline => self.byline,
      :roles => self.all_roles.map{ |r| { id: r[:id], token: r[:token], name: r[:name], description: r[:description],
                                          application_name: r[:application_name], application_id: r[:application_id], explicit: r[:explicit] } },
      :favorites => self.favorites.map{ |f| { id: f.id, name: f.name, type: f.type } },
      :explicit_group_memberships => self.explicit_groups.map{ |g| { id: g.id, name: g.name, type: g.type, ou: g.ou?, explicit: true } },
      :calculated_group_memberships => self.calculated_groups.map{ |g| { id: g.id, name: g.name, type: g.type, ou: g.ou?, explicit: false } },
      :group_memberships => self.explicit_groups.map{ |g| { id: g.id, name: g.name, type: g.type, ou: g.ou?, explicit: true } } + self.calculated_groups.map{ |g| { id: g.id, name: g.name, type: g.type, ou: g.ou?, explicit: false } },
      :group_ownerships => self.group_ownerships.map{ |o| { id: o.id, name: o.name, type: o.type } },
      :group_operatorships => self.group_operatorships.map{ |o| { id: o.id, name: o.name, type: o.type } }
    }
  end
  
  def trigger_sync
    logger.info "Person #{id}: trigger_sync called, calling trigger_sync on #{explicit_roles.length} roles"
    explicit_roles.all.each { |role| role.trigger_sync }
    return true
  end
  
  def first_or_last_presence
    unless self.name.length > 0
      errors.add(:name, "first or last must be set")
    end
  end
end
