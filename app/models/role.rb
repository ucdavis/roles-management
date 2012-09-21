class Role < ActiveRecord::Base
  validates :token, :uniqueness => { :scope => :id, :message => "token must be unique per application" }
  validates :application_id, :presence => true # must have an application

  has_many :role_assignments, :dependent => :destroy
  has_many :people, :through => :role_assignments
  has_many :groups, :through => :role_assignments
  after_save :sync_ad

  belongs_to :application

  attr_accessible :token, :people_tokens, :people_ids, :default, :group_tokens, :descriptor, :description, :ad_path
  attr_reader :people_tokens, :group_tokens

  def uids
    uids = []

    uids += self.person_ids.map{ |x| '1' + x.to_s }
    uids += self.group_ids.map{ |x| '2' + x.to_s }
  end

  def people_tokens=(ids)
    self.person_ids = ids.split(",").collect { |x| x[1..-1] } # cut off the UID (see README)
  end
  def group_tokens=(ids)
    self.group_ids = ids.split(",").collect { |x| x[1..-1] } # cut off the UID (see README)
  end

  def as_json(options={})
    { :id => self.id, :token => self.token, :descriptor => self.descriptor, :application_id => self.application_id, :description => self.description, :mandatory => self.mandatory, :default => self.default, :uids => self.uids }
  end

  def to_csv
    data = []

    members.each do |m|
      data << [token, m.uid, m.loginid, m.email, m.first, m.last]
    end

    return data
  end

  # Slightly different than 'people' or 'groups' ...
  # members takes all people and all people from groups (flattens the group)
  # and returns them as a list. It also computes the full list of people
  # who have access to an application if the role is named 'access' (e.g. include people in other roles,
  # mimicking the frontend interface and making AD sync behave the same way)
  def members
    all = []

    # Add all people
    all += people

    # Add all (flattened) groups
    groups.each do |group|
      all += group.members(true)
    end

    # If this is the 'access' role, add all members of all other roles
    if token == "access"
      application.roles.reject{ |r| r.token == "access" }.each do |role|
        all += role.members
      end
    end

    # Return a unique list
    all.uniq{ |x| x.uid }
  end

  # Syncronizes with AD
  # Note: Due to AD's architecture, this cannot be verified as a success right away
  def sync_ad
    require 'AdSync'

    unless ad_path.nil?
    logger.info "Syncing role #{id} (#{application.name} / #{token}) with AD..."
      g = AdSync.fetch_group(ad_path)

      unless g.nil?
        logger.info "Found group #{ad_path} in AD."

        # Add members to AD
        members.each do |member|
          u = AdSync.fetch_user(member.loginid)
          unless AdSync.in_group(u, g)
            logger.info "Adding user #{u[:samaccountname]} to AD group #{ad_path}"
            AdSync.add_user_to_group(u, g)
          else
            logger.info "User #{u[:samaccountname]} is already in AD group #{ad_path}"
          end
        end

        # Add AD people as members
        ad_members = AdSync.list_group_members(g)
        role_members = members.map{ |x| x.loginid }
        ad_members.each do |m|
          unless role_members.include? m[:samaccountname]
            p = Person.find_by_loginid m[:samaccountname]
            people << p unless p.nil?
            logger.info "Adding user #{m[:samaccountname]} from AD group #{ad_path} in AD."
          else
            logger.info "User #{m[:samaccountname]} is already in RM and doesn't need to be synced back from AD."
          end
        end
      else
        logger.info "Could not find group #{ad_path} in AD."
      end

      logger.info "Done syncing role #{id} with AD."
    else
      logger.info "Not syncing role #{id} because no AD path is set"
    end
  end
  handle_asynchronously :sync_ad
end
