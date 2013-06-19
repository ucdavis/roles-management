# A role has both 'entities' and 'members'.
# Ultimately, 'entities' is the only model assigned to a role.
# An entity is either a Person or Group.
# 'Members' refers only to people and is calculated by flattening
# groups down to people.
class Role < ActiveRecord::Base
  using_access_control

  validates :token, :uniqueness => { :scope => :id, :message => "token must be unique per application" }
  validates :application_id, :presence => true # must have an application
  validate :must_own_associated_application

  has_many :role_assignments, :dependent => :destroy

  has_many :entities, :through => :role_assignments,
                      :after_add => Proc.new{ |r|
                                               r.entities_changed = true
                                             },
                      :after_remove => Proc.new{ |r|
                                                 r.entities_changed = true
                                               }
  before_save :clear_last_sync_if_path_changed
  after_save :sync_ad

  belongs_to :application

  attr_accessible :token, :entity_ids, :name, :description, :ad_path
  attr_accessor :skip_next_sync   # flag which may be set by manipulating code to avoid an AD sync
  attr_accessor :entities_changed # flag used by has_many :entities add/remove to force a role sync
  attr_accessor :force_sync       # flag used to force a sync on save or explicit call to Role.sync_ad
  
  def as_json(options={})
    { :id => self.id, :token => self.token, :name => self.name, :application_id => self.application_id,
      :description => self.description,
      :entities => self.entities.map{ |e| { type: e.type, id: e.id, name: e.name } }, :ad_path => self.ad_path,
      :members => self.members.map{ |m| { id: m.id, name: m.name, loginid: m.loginid } } }
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
    all += entities.where(:type => "Person").all

    # Add all (flattened) groups
    entities.where(:type => "Group").all.each do |group|
      all += group.flattened_members
    end

    # Return a unique list
    all.uniq{ |x| x.id }
  end

  # Syncronizes with AD
  # Note: Due to AD's architecture, this cannot be verified as a success right away
  def sync_ad
    # AD sync will update the role's "last_ad_sync" member. Ensure we don't
    # end up recursively calling this after_save callback!
    if (self.skip_next_sync != true) || self.force_sync
      if (self.ad_path_changed? || self.entities_changed || self.force_sync) && self.ad_path
        require 'rake'
        load File.join(Rails.root, 'lib', 'tasks', 'ad_sync.rake')

        logger.info "Scheduling AD sync for role #{id}"
        Delayed::Job.enqueue(DelayedRake.new("ad:sync_role[#{id}]"))
      else
        logger.info "Not syncing AD as ad_path_changed? is #{self.ad_path_changed?}, entities_changed is #{self.entities_changed}, force_sync is #{self.force_sync}, or AD path may be blank '#{self.ad_path}'."
      end
    else
      logger.info "Not scheduling AD sync for role #{id} as skip_next_sync was set #{self.skip_next_sync} and force_sync was unset #{self.force_sync}."
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
