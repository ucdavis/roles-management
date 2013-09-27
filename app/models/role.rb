# A role has both 'entities' and 'members'.
# Ultimately, 'entities' is the only model assigned to a role.
# An entity is either a Person or Group.
# 'Members' refers only to people and is calculated by flattening
# groups down to people.
class Role < ActiveRecord::Base
  using_access_control

  validates :token, :uniqueness => { :scope => :id, :message => "token must be unique per application" }
  validates :application_id, :presence => true # must have an application

  has_many :role_assignments, :dependent => :destroy
  has_many :entities, :through => :role_assignments

  belongs_to :application

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

  # Slightly different than 'entities' ...
  # members takes all people and all people from groups (flattens the group)
  # and returns them as a list. It also only returns unique results, so e.g. if
  # a person has this role via two different groups, they will only appear once
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
    if self.ad_path # && (self.ad_path_changed? || self.force_ad_sync)
      require 'rake'
      require 'delayed_job_active_record'
      
      load File.join(Rails.root, 'lib', 'tasks', 'ad_sync.rake')

      logger.info "Scheduling AD sync for role #{id}"
      Delayed::Job.enqueue(DelayedRake.new("ad:sync_role[#{id}]"))
    else
      logger.info "Not scheduling AD sync for role #{id} as AD path is not set."
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
end
