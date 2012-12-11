class Person < Entity
  using_access_control

  belongs_to :title
  has_many :affiliation_assignments, :dependent => :destroy
  has_many :affiliations, :through => :affiliation_assignments, :uniq => true

  has_and_belongs_to_many :groups, :foreign_key => "entity_id", :join_table => :entities_groups, :uniq => true

  has_many :role_assignments, :foreign_key => "entity_id", :dependent => :destroy
  has_many :roles, :through => :role_assignments

  has_many :favorite_relationships, :class_name => "PersonFavoriteAssignment", :foreign_key => "favorite_id"
  has_many :favorites, :through => :favorite_relationships, :source => :favorite

  has_many :application_owner_assignments, :foreign_key => "owner_id", :dependent => :destroy
  has_many :application_ownerships, :through => :application_owner_assignments, :source => :application

  has_many :group_operator_assignments, :foreign_key => "entity_id"
  has_many :group_operatorships, :through => :group_operator_assignments, :source => :group

  has_many :group_owner_assignments, :foreign_key => "entity_id"
  has_many :group_ownerships, :through => :group_owner_assignments, :source => :group

  has_one :student

  belongs_to :major

  validates :loginid, :presence => true, :uniqueness => true

  attr_accessible :name, :first, :last, :loginid, :email, :phone, :address, :type, :role_ids, :favorite_ids, :group_ids, :ou_ids

  def self.csv_header
    "ID,Login ID, Email, First, Last".split(',')
  end

  def to_csv
    [id, loginid, email, first, last]
  end

  def name
    first + " " + last
  end

  # Compute their classifications based on their title
  def classifications
    title.classifications
  end

  def ou_ids=(ids)
    # Add any new OUs
    ids.each do |id|
      ou = Group.find_by_id(id, :conditions => "code not null")
      unless (groups.include? ou) or ou.nil?
        groups << ou
      end
    end

    # Remove any OUs not mentioned (ou_ids= behavior is to always give the complete list)
    groups.ous.each do |ou|
      unless ids.include? ou.id
        groups.delete(ou.id)
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

  # Compute applications for which they can make assignments.
  # These are applications they either explicitly own or
  # applications made available on a global level.
  def manageable_applications
    apps = []

    # Admins can see all applications
    if is_rm_admin?
      apps = Application.all
    else
      # Add apps where they are explicitly the owners
      application_ownerships.each do |a|
        apps << a
      end
    end

    apps
  end

  # Compute accessible applications
  def applications
    apps = []

    # Add apps via roles explicitly assigned
    roles.each { |role| apps << role.application }

    apps
  end

  # List all available apps person does not have
  def requestable_applications
    apps = []

    # Query all applications with an empty '.ous', implying public availability (some apps are for specific OUs only)
    Application.includes(:application_ou_assignments).where( :application_ou_assignments => { :application_id => nil } ).each do |application|
      unless applications.include? application
        # App is publicly available and not already in their list
        apps << application
      end
    end

    # Add applications available to their OUs but to which they have no roles
    ous.each do |ou|
      ou.applications.each do |application|
        application.roles.where(:default => false).each do |role|
          unless applications.include? application
            apps << application
          end
        end
      end
    end

    apps
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
    { :id => self.id, :name => self.first + " " + self.last }
  end

  def can_administer_application?(app_id)
    applications.collect{ |x| x.id }.include? app_id
  end

  # SECUREME: Does it matter that this computes based on favorites now?
  def can_administer_person?(person_id)
    favorites.collect{ |x| x.id }.include? person_id
  end

  def can_administer_group?(group_id)
    groups.collect{ |x| x.id }.include? group_id
  end

  def can_administer_role?(role_id)
    applications.collect{|x| x.role_ids}.flatten.include? role_id
  end

  # Returns true if this user is an admin of "DSS Roles Management" itself
  def is_rm_admin?
    roles.includes(:application).where(:token => "admin", :applications => { :name => "DSS Roles Management" }).exists?
  end
end
