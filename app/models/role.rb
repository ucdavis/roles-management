require 'sync'

# A role has both 'entities' and 'members'.
# Ultimately, 'entities' is the only model assigned to a role.
# An entity is either a Person or Group.
# 'Members' refers only to people and is calculated by flattening
# groups down to people.
class Role < ActiveRecord::Base
  using_access_control

  validates :application_id, :presence => true
  validates :token, :uniqueness => { :scope => :application_id, :message => "token must be unique per application" }
  validate :ad_path_cannot_be_blank_if_present

  has_many :role_assignments, :dependent => :destroy
  has_many :entities, :through => :role_assignments

  belongs_to :application, :touch => true

  # before_save :reset_last_ad_sync_if_ad_path_changed
  after_save :trigger_sync_if_needed

  # DO NOT add entity_ids to this list - removing entities that way goes through
  # a has_many :through and will _not_ trigger important before_destroy callbacks in RoleAssignment.
  # This is noted in the Rails documentation. Remove entities via roles_attributes.
  attr_accessible :token, :role_assignments_attributes, :name, :description, :ad_path, :application_id
  accepts_nested_attributes_for :role_assignments, :allow_destroy => true

  def as_json(options={})
    logger.warn "Role.as_json called. Should be using jbuilder."
    { :id => self.id, :token => self.token, :name => self.name, :application_id => self.application_id,
      :description => self.description,
      :assignments => self.role_assignments.map{ |a| { id: a.id, calculated: a.parent_id?, entity_id: a.entity_id, name: a.entity.name, type: a.entity.type } }
     }
  end

  # Returns identifying string for logging purposes. Other classes implement this too.
  # Format: (Class name:id,identifying fields)
  def log_identifier
    "(Role:#{id},#{application.name}/#{token})"
  end

  def to_csv
    data = []

    members.each do |m|
      data << [token, m.id, m.loginid, m.email, m.first, m.last] if m.active
    end

    return data
  end

  # Different from entities, 'members' takes all people and all people from groups
  # (flattens the group) and returns them as a list. It also only returns unique results,
  # so e.g. if a person has this role via two different groups, they will only appear once
  # in the members output, but at least twice in the 'entities' output.
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

  # Triggers the sync subsystem on this role
  def sync_role_increment(person_id)
    Sync.person_added_to_role(person_id, self.id)
  end
  def sync_role_decrement(person_id)
    Sync.person_removed_from_role(person_id, self.id)
  end

  # Syncronizes with AD
  # Note: Due to AD's architecture, this cannot be verified as a success right away
  def sync_ad_increment(person_id)
    if self.ad_path and (self.ad_path.length > 0)
      require 'rake'

      load File.join(Rails.root, 'lib', 'tasks', 'ad_sync.rake')

      logger.info "Scheduling AD sync for role #{id}"
      Delayed::Job.enqueue(DelayedRake.new("ad:sync_role[#{id}]"))
    else
      logger.info "Not scheduling AD sync for role #{id} as AD path is not set."
    end
  end
  # TODO: Make this function and the one above actually selective add/remove.
  #       Right now they both just take a sledgehammer to the AD role.
  def sync_ad_decrement(person_id)
    if self.ad_path and (self.ad_path.length > 0)
      require 'rake'

      load File.join(Rails.root, 'lib', 'tasks', 'ad_sync.rake')

      logger.info "Scheduling AD sync for role #{id}"
      Delayed::Job.enqueue(DelayedRake.new("ad:sync_role[#{id}]"))
    else
      logger.info "Not scheduling AD sync for role #{id} as AD path is not set."
    end
  end

  # trigger_sync!'s purpose is to handle whatever needs to be done
  # with the syncing architecture (e.g. person changes, trigger roles to sync so
  # Active Directory, etc. can be updated)
  def trigger_increment_sync!(person_id)
    unless Thread.current[:will_sync_role] and Thread.current[:will_sync_role].include? id
      logger.debug "Role #{id}: trigger_increment_sync! called"
      sync_role_increment(person_id)
      sync_ad_increment(person_id)
    else
      logger.debug "Role #{id}: trigger_sync! called but skipping as will_sync_role lock exists"
    end
  end

  def trigger_decrement_sync!(person_id)
    unless Thread.current[:will_sync_role] and Thread.current[:will_sync_role].include? id
      logger.debug "Role #{id}: trigger_decrement_sync! called"
      sync_role_decrement(person_id)
      sync_ad_decrement(person_id)
    else
      logger.debug "Role #{id}: trigger_sync! called but skipping as will_sync_role lock exists"
    end
  end

  private

  def ad_path_cannot_be_blank_if_present
    if self.ad_path and self.ad_path.blank?
      self.ad_path = nil
    end
  end

  def trigger_sync_if_needed
    # ad_path was set for the first time, so sync
    if self.ad_path and self.ad_path_was == nil
      self.trigger_sync!
    end
  end
end
