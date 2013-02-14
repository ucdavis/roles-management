class Role < ActiveRecord::Base
  using_access_control

  validates :token, :uniqueness => { :scope => :id, :message => "token must be unique per application" }
  validates :application_id, :presence => true # must have an application
  validate :must_own_associated_application

  has_many :role_assignments, :dependent => :destroy
  has_many :entities, :through => :role_assignments
  before_save :clear_last_sync_if_path_changed
  after_save :sync_ad

  belongs_to :application

  attr_accessible :token, :entity_ids, :default, :name, :description, :ad_path
  attr_accessor :skip_next_sync

  # Needed in show.json.rabl to display a role's application's name
  def application_name
    application.name
  end

  def as_json(options={})
    { :id => self.id, :token => self.token, :name => self.name, :application_id => self.application_id,
      :description => self.description, :mandatory => self.mandatory, :default => self.default,
      :entities => self.entities.map{ |e| { type: e.type, id: e.id, name: e.name } }, :ad_path => self.ad_path }
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
    # AD sync will update the role's "last_ad_sync" member. Ensure we don't
    # end up recursively calling this after_save callback!
    unless self.skip_next_sync
      require 'rake'
      load File.join(Rails.root, 'lib', 'tasks', 'ad_sync.rake')

      logger.info "Scheduling AD sync for role #{id}"
      Delayed::Job.enqueue(DelayedRake.new("ad:sync_role[#{id}]"))
    else
      logger.info "Not scheduling AD sync as skip_next_sync was set."
      self.skip_next_sync = false
    end
  end

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
    logger.error "SECUREME: Implementation needed."
  end

  def clear_last_sync_if_path_changed
    if self.ad_path_changed?
      self.last_ad_sync = nil
    end
  end
end
