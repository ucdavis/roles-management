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
    { :id => self.id, :token => self.token, :name => self.name, :application_id => self.application_id,
      :description => self.description,
      :assignments => self.role_assignments.map{ |a| { id: a.id, calculated: a.parent_id?, entity_id: a.entity_id, name: a.entity.name, type: a.entity.type } }
     }
  end

  def to_csv
    data = []

    members.each do |m|
      data << [token, m.id, m.loginid, m.email, m.first, m.last]
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

  # Syncronizes with AD
  # Note: Due to AD's architecture, this cannot be verified as a success right away
  def sync_ad
    if self.ad_path and (self.ad_path.length > 0)
      require 'rake'
      
      load File.join(Rails.root, 'lib', 'tasks', 'ad_sync.rake')

      logger.info "Scheduling AD sync for role #{id}"
      Delayed::Job.enqueue(DelayedRake.new("ad:sync_role[#{id}]"))
    else
      logger.info "Not scheduling AD sync for role #{id} as AD path is not set."
    end
  end

  # trigger_sync! exists in Person and Group as well
  # It's purpose is to merely handle whatever needs to be done
  # with the syncing architecture (e.g. person changes, trigger roles to sync so
  # Active Directory, etc. can be updated)
  def trigger_sync!
    unless Thread.current[:will_sync_role] and Thread.current[:will_sync_role].include? id
      logger.info "Role #{id}: trigger_sync! called, calling sync_ad"
      sync_ad
    else
      logger.debug "Role #{id}: trigger_sync! called but skipping as will_sync_role lock exists"
    end
  end
  
  private
  
  # If the ad_path was changed in any way, reset the last_ad_sync to ensure
  # the next AD sync is a two-way sync. (It is only two-way for the first sync,
  # one-way after that.)
  # def reset_last_ad_sync_if_ad_path_changed
  #   if self.ad_path_changed?
  #     self.last_ad_sync = nil
  #   end
  # end
  
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

# Thread-level list of roles which are scheduled to be synced.
# Used to avoid multiple role syncs due to the flurry of callbacks
# that occur when personal data is changed.
# e.g. Person gains new Title -> recalculates group rule ->
#      alters group membership -> group has role so trigger_sync
#      is called for every recalculated group rule member.
#      Also used when a group gains a role to avoid having all
#      its members individually trigger role syncs, i.e. because
#      N-member-role assignments will be created, each calling
#      trigger_sync.
Thread.current[:will_sync_role] = []
