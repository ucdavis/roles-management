class Person < Entity
  using_access_control

  belongs_to :title
  has_many :affiliation_assignments, :dependent => :destroy
  has_many :affiliations, :through => :affiliation_assignments, :uniq => true

  has_and_belongs_to_many :groups, :uniq => true
  has_many :role_assignments, :foreign_key => "entity_id", :dependent => :destroy

  has_many :person_manager_assignments, :dependent => :destroy
  has_many :managers, :through => :person_manager_assignments
  has_many :subordinate_relationships, :class_name => "PersonManagerAssignment", :foreign_key => "manager_id"
  has_many :subordinates, :through => :subordinate_relationships, :source => :subordinate

  has_many :application_owner_assignments, :foreign_key => "owner_id", :dependent => :destroy
  has_many :application_ownerships, :through => :application_owner_assignments, :source => :application

  has_many :group_operator_assignments, :foreign_key => "operator_person_id"

  has_one :student

  belongs_to :major

  validates :loginid, :presence => true, :uniqueness => true

  attr_accessible :first, :last, :loginid, :email, :phone, :status, :address, :name, :ou_tokens, :ou_ids, :group_tokens, :group_ids, :subordinate_tokens, :name
  attr_reader :ou_tokens, :group_tokens, :subordinate_tokens

  def self.csv_header
    "ID,Login ID, Email, First, Last".split(',')
  end

  def to_csv
    [id, loginid, email, first, last]
  end

  # Compute their classifications based on their title
  def classifications
    title.classifications
  end

  # An OU is a group with a (title) code
  def ous
    groups.where(Group.arel_table[:code].not_eq(nil))
  end

  # Compute roles
  # Scope can be one of the following:
  #       :here (default) - Only show roles from this application
  #       :all            - Show all roles from all applications
  def roles(scope = :all)
    roles = []

    case scope
      when :here
        # Add roles explicitly assigned
        role_assignments.where(:role_id => Application.find_by_name("DSS Roles Management").roles).each do |assignment|
          roles << assignment.role
        end

        # Add roles implicitly assigned via groups
        RoleAssignment.where(:group_id => groups, :role_id => Application.find_by_name("DSS Roles Management").roles).each do |assignment|
          roles << assignment.role
        end
      when :all
        # Add roles explicitly assigned
        role_assignments.each do |assignment|
          roles << assignment.role
        end

        groups.each do |g|
          g.roles.each do |role|
            unless roles.include? role
              roles << role
            end
          end
        end
    end

    roles
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
      ids << {:id => group.id, :name => group.name}
    end
    operates.each do |group|
      ids << {:id => group.id, :name => group.name}
    end
    subordinates.each do |person|
      ids << {:id => person.id, :name => person.name}
    end

    ids
  end

  # FIXME: Duplicate of the above function - remove manageable_ids once the
  # refactoring toward an Entity controller is complete
  def entities
    entities = []

    owns.each do |group| # includes OUs
      entities << {:id => group.id, :name => group.name}
    end
    operates.each do |group|
      entities << {:id => group.id, :name => group.name}
    end
    subordinates.each do |person|
      entities << {:id => person.id, :name => person.name}
    end

    entities
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
    group_operator_assignments.includes(:group).where(:operator_person_id => id).map{|x| x.group}
  end

  # ACL symbols
  def role_symbols
    syms = []

    roles(:here).each do |role|
      syms << role.token.underscore.to_sym
    end

    # All people in the database have the default role of 'access'
    syms << "access".to_sym unless syms.include? :access

    syms
  end

  def as_json(options={})
    { :id => self.id, :name => self.first + " " + self.last }
  end

  def group_tokens=(ids)
    self.group_ids = ids.split(",")
  end

  def subordinate_tokens=(ids)
    ids = ids.split(",")

    # Remove any unmentioned IDs
    subordinates.each do |s|
      if (ids.include? s.id) == false
        s.managers.delete self
      end
    end

    # Add the rest
    ids.each do |id|
      p = Person.find_by_id(id)
      if (p.managers.include? self) == false
        p.managers << self
        p.save
      end
    end
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
