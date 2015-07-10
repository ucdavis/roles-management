# A role has both 'entities' and 'members'.
# Ultimately, 'entities' is the only model assigned to a role.
# An entity is either a Person or Group.
# 'Members' refers only to people and is calculated by flattening
# groups down to people.
class Role < ActiveRecord::Base
  # SYNC_ROLE_ATTRS is the list of role attribtues we care to notify
  # the sync subsystem about.
  SYNC_ROLE_ATTRS = ["ad_path", "token", "name", "description"]

  using_access_control

  validates :application_id, :presence => true
  validates :token, :uniqueness => { :scope => :application_id, :message => "token must be unique per application" }
  validate :ad_path_cannot_be_blank_if_present

  has_many :role_assignments, :dependent => :destroy
  has_many :entities, :through => :role_assignments

  belongs_to :application, :touch => true

  after_save :trigger_sync_if_changed

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

  def name_with_application
    "#{self.application.name} / #{self.name}"
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

  private

  def ad_path_cannot_be_blank_if_present
    if self.ad_path and self.ad_path.blank?
      self.ad_path = nil
    end
  end

  def trigger_sync_if_changed
    if (self.changed & SYNC_ROLE_ATTRS).length > 0
      Sync.role_changed(Sync.encode(self, true).merge({ :changes => self.changes.select{ |c, v| SYNC_ROLE_ATTRS.include?(c) } }))
    end
  end
end
