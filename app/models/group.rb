require 'benchmark'

# Group shares many attributes with entity.
class Group < Entity
  has_many :memberships, class_name: 'GroupMembership', dependent: :destroy
  has_many :role_assignments, foreign_key: 'entity_id', dependent: :destroy
  has_many :roles, through: :role_assignments, dependent: :destroy
  has_many :group_ownerships, dependent: :destroy
  has_many :owners, through: :group_ownerships, source: 'entity', dependent: :destroy
  has_many :application_ownerships, foreign_key: 'entity_id', dependent: :destroy
  has_many :application_operatorships, foreign_key: 'entity_id', dependent: :destroy
  has_many :group_operatorships, dependent: :destroy
  has_many :operators, through: :group_operatorships, source: 'entity', dependent: :destroy
  has_many :rules, foreign_key: 'group_id', class_name: 'GroupRule', dependent: :destroy

  validates_presence_of :name

  accepts_nested_attributes_for :rules, allow_destroy: true
  accepts_nested_attributes_for :memberships, allow_destroy: true
  accepts_nested_attributes_for :role_assignments, allow_destroy: true

  after_create do |group|
    ActivityLog.info!("Created group #{group.name}.", ["group_#{group.id}", 'system'])
  end

  after_destroy do |group|
    ActivityLog.info!("Deleted group #{group.name}.", ['system'])
  end

  # Returns identifying string for logging purposes. Other classes implement this too.
  # Format: (Class name:id,identifying fields)
  def log_identifier
    "(Group:#{id},#{name})"
  end

  # Return both explicitly-assigned and calculated (rule-based) members
  def members
    _members = []
    time = Benchmark.measure do
      _members = Rails.cache.fetch("group/#{id}/members/#{updated_at.to_f}") do
        Person.where(id: (memberships.pluck(:entity_id) + GroupsService.rule_member_ids(self)).uniq)
      end
    end

    Rails.logger.warn "Group.members for group with ID #{id} took #{time.real}" if time.real > 0.50

    return _members
  end

  def rule_members
    Person.where(id: GroupsService.rule_member_ids(self).uniq)
  end
end
