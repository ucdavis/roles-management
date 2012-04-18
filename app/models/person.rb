class Person < ActiveRecord::Base
  belongs_to :title
  has_many :affiliation_assignments
  has_many :affiliations, :through => :affiliation_assignments, :uniq => true
  
  has_and_belongs_to_many :groups
  has_many :role_assignments
  
  has_many :person_manager_assignments
  has_many :managers, :through => :person_manager_assignments
  has_many :subordinate_relationships, :class_name => "PersonManagerAssignment", :foreign_key => "manager_id"
  has_many :subordinates, :through => :subordinate_relationships, :source => :subordinate
  
  has_many :application_manager_assignments, :foreign_key => "manager_id"
  has_many :application_ownerships, :through => :application_manager_assignments, :source => :application
  
  has_many :group_manager_assignments
  
  validates_presence_of :loginid
  
  attr_accessible :first, :last, :loginid, :email, :phone, :status, :address, :preferred_name, :ou_tokens, :ou_ids, :group_tokens, :group_ids, :subordinate_tokens
  attr_reader :ou_tokens, :group_tokens, :subordinate_tokens
  
  def name
      "#{first} #{last}"
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
  def roles
    roles = []
    
    # Add roles explicitly assigned
    role_assignments.each do |assignment|
      roles << assignment.role
    end
    
    # Add roles via OU defaults
    #ous.each do |ou|
    #  ou.applications.each do |application|
    #    application.roles.where(:default => true).each do |role|
    #      # Ensure there are no duplicates
    #      unless roles.include? role
    #        roles << role
    #      end
    #    end
    #  end
    #end

    # Add roles via public defaults
    #Role.includes(:application).where( :default => true ).each do |role|
      # Avoid duplicates
      #unless roles.include? role
        #roles << role
        #end
    #end
    groups.each do |g|
      g.roles.each do |role|
        unless roles.include? role
          roles << role
        end
      end
    end
    
    roles
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
    
    # Add apps via OU defaults
    #ous.each do |ou|
    #  ou.applications.each do |application|
    #    application.roles.where(:default => true).each do |role|
    #      # Ensure there are no duplicates
    #      unless apps.include? role.application
    #        apps << role.application
    #      end
    #    end
    #  end
    #end
    
    # Add apps open to the public
    # DON'T DO THIS - default role does not imply public access
    #Role.includes(:application).where( :default => true ).each do |role|
      # Avoid duplicates
      #unless apps.include? role.application
        #apps << role.application
        #end
    #end
    
    apps
  end
  
  # Compute accessible applications
  def applications
    apps = []
    
    # Add apps via roles explicitly assigned
    roles.each { |role| apps << role.application }

    # Add apps via OU defaults
    ous.each do |ou|
      ou.applications.each do |application|
        application.roles.where(:default => true).each do |role|
          # Ensure there are no duplicates
          unless apps.include? role.application
            apps << role.application
          end
        end
      end
    end
    
    # Add apps via public defaults
    # DON'T DO THIS - default role does not imply public access
    #Role.includes(:application).where( :default => true ).each do |role|
      # Avoid duplicates
      #unless apps.include? role.application
        #apps << role.application
        #end
    #end

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
    groups = []
    
    GroupOwnerAssignment.includes(:group).where(:owner_id => id).each do |ownership|
      groups << ownership.group
    end
    
    groups
  end
  
  # ACL symbols
  def role_symbols
    # Get this app's API key
    api_key = YAML.load_file("#{Rails.root.to_s}/config/api_keys.yml")['keys']['key']
    
    syms = []
    
    # Query for permissions of user via API key, converting them into declarative_authentication's needed symbols
    roles.each do |role|
      if role.application.api_key == api_key
        syms << role.token.underscore.to_sym
      end
    end
    
    syms
  end

  # Exports UIDs
  def as_json(options={}) 
    { :id => ('1' + self.id.to_s).to_i, :name => self.first + " " + self.last } 
  end

  def ou_tokens=(ids)
    self.ou_ids = ids.split(",").collect { |x| x[1..-1] } # cut off the UID (see README)
  end

  def group_tokens=(ids)
    self.group_ids = ids.split(",").collect { |x| x[1..-1] } # cut off the UID (see README)
  end
  
  def subordinate_tokens=(ids)
    ids = ids.split(",").collect { |x| x[1..-1] } # cut off the UID (see README)
    
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
