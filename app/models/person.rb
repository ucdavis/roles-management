class Person < Entity
  using_access_control

  belongs_to :title
  has_many :affiliation_assignments, :dependent => :destroy
  has_many :affiliations, :through => :affiliation_assignments, :uniq => true

  has_and_belongs_to_many :groups, :foreign_key => "entity_id", :join_table => :entities_groups, :uniq => true

  has_many :role_assignments, :foreign_key => "entity_id", :dependent => :destroy
  has_many :roles, :through => :role_assignments

  has_many :person_manager_assignments, :dependent => :destroy
  has_many :managers, :through => :person_manager_assignments
  has_many :subordinate_relationships, :class_name => "PersonManagerAssignment", :foreign_key => "manager_id"
  has_many :subordinates, :through => :subordinate_relationships, :source => :subordinate

  has_many :application_owner_assignments, :foreign_key => "owner_id", :dependent => :destroy
  has_many :application_ownerships, :through => :application_owner_assignments, :source => :application

  has_many :group_operator_assignments, :foreign_key => "entity_id"
  has_many :group_owner_assignments, :foreign_key => "entity_id"

  has_one :student

  belongs_to :major

  validates :loginid, :presence => true, :uniqueness => true

  attr_accessible :name, :first, :last, :loginid, :email, :phone, :address, :role_ids, :subordinate_ids, :group_ids, :ou_ids

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

  # An OU is a group with a (title) code
  def ous
    groups.where(Group.arel_table[:code].not_eq(nil))
  end

  def roles_by_application(application_id)
    Role.includes(:role_assignments).where(:application_id => application_id, :role_assignments => { :entity_id => self.id } ).map{ |x| x.token }
  end

  def roles_by_api_key(api_key_id)
    api_key_role_ids = Application.find_by_api_key_id(api_key_id).roles.map { |x| x.id }
    roles.reject{ |x| ! api_key_role_ids.include? x.id }
  end

  # Compute applications they can assign subordinates to.
  # These are applications they either explicitly own or
  # applications made available on a global level.
  def manageable_applications
    apps = []

    # Add apps where they are explicitly the owners
    application_ownerships.each do |a|
      apps << a
    end

    apps
  end

  # Returns IDs (and some additional info) of all subordinates
  # and groups which this person can assign (owns and operates).
  def manageable_ids
    ids = []

    owns.each do |group| # includes OUs
      ids << {:id => group.id, :name => group.name, :type => "group"}
    end
    operates.each do |group|
      ids << {:id => group.id, :name => group.name, :type => "group"}
    end
    subordinates.each do |person|
      ids << {:id => person.id, :name => person.name, :type => "person"}
    end

    ids
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

  # Returns all groups owned by this person (see 'manages' for people)
  def owns
    group_owner_assignments.includes(:group).where(:entity_id => id).map{|x| x.group}
  end

  # Returns all groups operated by this person (see 'manages' for people, 'owns' for group ownerships)
  def operates
    group_operator_assignments.includes(:group).where(:entity_id => id).map{ |x| x.group }
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

  def can_administer_person?(person_id)
    subordinates.collect{ |x| x.id }.include? person_id
  end

  def can_administer_group?(group_id)
    groups.collect{ |x| x.id }.include? group_id
  end

  def can_administer_role?(role_id)
    applications.collect{|x| x.role_ids}.flatten.include? role_id
  end
end
