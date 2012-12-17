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
    { :id => self.id, :token => self.token, :name => self.name, :application_id => self.application_id, :description => self.description, :mandatory => self.mandatory, :default => self.default, :entities => self.entities }
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

  private

  # No changes can be made to this role unless the user owns the associated application
  def must_own_associated_application
    logger.error "Implementation needed."
  end
end
