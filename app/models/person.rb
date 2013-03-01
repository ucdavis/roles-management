# Person shares many attributes with entity.
# Note that the 'name' field is simply self.first + " " + self.last
# and is thus read-only. The same does not apply for groups.
class Person < Entity
  using_access_control

  belongs_to :title
  has_many :affiliation_assignments, :dependent => :destroy
  has_many :affiliations, :through => :affiliation_assignments, :uniq => true

  has_and_belongs_to_many :group_memberships, :class_name => "Group", :foreign_key => "entity_id", :join_table => :entities_groups, :uniq => true

  has_many :role_assignments, :foreign_key => "entity_id", :dependent => :destroy
  has_many :roles, :through => :role_assignments

  has_many :favorite_relationships, :class_name => "PersonFavoriteAssignment", :foreign_key => "favorite_id"
  has_many :favorites, :through => :favorite_relationships, :source => :favorite

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

  attr_accessible :first, :last, :loginid, :email, :phone, :address, :type, :role_ids, :favorite_ids, :group_membership_ids, :ou_ids, :group_ownership_ids, :group_operatorship_ids

  after_save :trigger_sync

  def self.csv_header
    "ID,Login ID, Email, First, Last".split(',')
  end

  def to_csv
    [id, loginid, email, first, last]
  end

  def byline
    unless title.nil?
      title.name + " (" + affiliations.map{ |x| x.name }.join(", ") + ")"
    else
      "(" + affiliations.map{ |x| x.name }.join(", ") + ")"
    end
  end

  # Compute their classifications based on their title
  def classifications
    title.classifications
  end

  def ou_ids=(ids)
    # Add any new OUs
    ids.each do |id|
      ou = Group.where(Group.arel_table[:code].not_eq(nil)).find_by_id(id)
      unless (group_memberships.include? ou) or ou.nil?
        group_memberships << ou
      end
    end

    # Remove any OUs not mentioned (ou_ids= behavior is to always give the complete list)
    group_memberships.ous.each do |ou|
      unless ids.include? ou.id
        group_memberships.delete(ou.id)
      end
    end
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

  # Compute applications for which they have a role.
  def accessible_applications
    apps = []

    # Add apps via roles explicitly assigned
    roles.each { |role| apps << role.application }

    apps.uniq{ |a| a.id }
  end

  # ACL symbols
  def role_symbols
    syms = []

    roles.where(:id => Application.find_by_name("DSS Roles Management").roles).each do |role|
      syms << role.token.underscore.to_sym
    end

    syms
  end

  def as_json(options={})
    { :id => self.id, :name => self.name, :type => 'Person', :loginid => self.loginid, :role_ids => self.role_ids, :roles => self.roles.map{ |r| { id: r.id, token: r.token, name: r.name, application_id: r.application_id } } }
  end

  def can_administer_application?(app_id)
    applications.collect{ |x| x.id }.include? app_id
  end

  # SECUREME: Does it matter that this computes based on favorites now?
  def can_administer_person?(person_id)
    favorites.collect{ |x| x.id }.include? person_id
  end

  def can_administer_group?(group_id)
    group_memberships.collect{ |x| x.id }.include? group_id
  end

  def can_administer_role?(role_id)
    applications.collect{|x| x.role_ids}.flatten.include? role_id
  end

  # Returns true if this user is an admin of "DSS Roles Management" itself
  def is_rm_admin?
    roles.includes(:application).where(:token => "admin", :applications => { :name => "DSS Roles Management" }).exists?
  end

  def trigger_sync
    logger.info "Person #{id}: trigger_sync called, calling trigger_sync on #{roles.length} roles"
    roles.all.each { |role| role.trigger_sync }
    return true
  end
end
