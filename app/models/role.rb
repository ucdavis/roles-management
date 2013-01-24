class Role < ActiveRecord::Base
  using_access_control

  validates :token, :uniqueness => { :scope => :id, :message => "token must be unique per application" }
  validates :application_id, :presence => true # must have an application
  validate :must_own_associated_application

  has_many :role_assignments, :dependent => :destroy
  has_many :entities, :through => :role_assignments
  after_save :sync_ad

  belongs_to :application

  attr_accessible :token, :entity_ids, :default, :name, :description, :ad_path

  # Needed in show.json.rabl to display a role's application's name
  def application_name
    application.name
  end

  def as_json(options={})
    { :id => self.id, :token => self.token, :name => self.name, :application_id => self.application_id, :description => self.description, :mandatory => self.mandatory, :default => self.default, :entities => self.entities, :ad_path => self.ad_path }
  end

  def to_csv
    data = []

    members.each do |m|
      data << [token, m.id, m.loginid, m.email, m.first, m.last]
    end

    return data
  end

  # Slightly different than 'entities' ...
  # members takes all people and all people from groups (flattens the group)
  # and returns them as a list.
  def members
    all = []

    # Add all people
    all += entities.where(:type => "Person")

    # Add all (flattened) groups
    entities.where(:type => "Group").each do |group|
      all += group.members(true)
    end

    # Return a unique list
    all.uniq{ |x| x.id }
  end

  # Syncronizes with AD
  # Note: Due to AD's architecture, this cannot be verified as a success right away
  def sync_ad
    require 'AdSync'

    Authorization.ignore_access_control(true)

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
        logger.debug "Syncing AD members back to local. There are #{ad_members.length} listed in AD and #{role_members.length} locally at the start."
        ad_members.each do |m|
          logger.debug "Syncing back #{m[:samaccountname]}"
          unless role_members.include? m[:samaccountname]
            logger.info "#{m[:samaccountname]} is not already in role_members, going to add ..."
            p = Person.find_by_loginid m[:samaccountname]
            if p
              entities << p
              logger.info "Adding user #{m[:samaccountname]} from AD group #{ad_path} to local group."
            else
              logger.warn "Need to add user #{m[:samaccountname]} from AD group #{ad_path} but could not be found locally."
            end
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

    Authorization.ignore_access_control(false)

    return true
  end
  handle_asynchronously :sync_ad

  # trigger_sync exists in Person and Group as well
  # It's purpose is to merely handle whatever needs to be done
  # with the syncing architecture (e.g. person changes, trigger roles to sync so
  # Active Directory, etc. can be updated)
  def trigger_sync
    logger.info "Role #{id}: trigger_sync called, calling sync_ad"
    sync_ad
  end

  private

  # No changes can be made to this role unless the user owns the associated application
  def must_own_associated_application
    logger.error "Implementation needed."
  end
end
