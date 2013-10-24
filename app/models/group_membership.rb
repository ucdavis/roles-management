# GroupMembership may be calculated, in which case they need to be destroyed only by the proper method,
# e.g. through a group and not a person. A group accomplishes this by using the destroying_calculated_group_membership do ... end
# block method below.
class GroupMembership < ActiveRecord::Base
  using_access_control
  
  @@destroy_calculated_membership_flag = false
  
  def self.destroy_calculated_membership_flag=(val)
    @@destroy_calculated_membership_flag = val
  end

  validates_presence_of :group, :entity
  validates_uniqueness_of :group_id, :scope => [:entity_id, :calculated]
  validate :group_cannot_join_itself
  validate :membership_cannot_be_cyclical
  before_destroy :destroying_calculated_membership_requires_flag

  belongs_to :group, :touch => true
  belongs_to :entity, :touch => true

  # Though this seems like 'group' logic, it must be done in this 'join table' class
  # as group memberships can be created outside the Group class causing
  # that Group's callbacks to go unused
  after_create :grant_group_roles_to_member
  after_create :recalculate_ou_group_rules_if_necessary
  before_destroy :remove_group_roles_from_member
  after_destroy :recalculate_ou_group_rules_if_necessary
  
  def self.destroying_calculated_group_membership
    begin
      GroupMembership.destroy_calculated_membership_flag = true
      yield
    ensure
      GroupMembership.destroy_calculated_membership_flag = false
    end
  end

  private
  
  # Alerts GroupRule to recalculate OU-based rules for this entity
  # if group is an OU.
  # This logic is located here and not in GroupRule as this is the best
  # place to find group memberships being created and destroyed.
  def recalculate_ou_group_rules_if_necessary
    if group.ou?
      GroupRule.resolve_target!(:ou, self.entity_id)
    end
  end
  
  # Grant group's roles to new member (marking as calculated)
  def grant_group_roles_to_member
    Rails.logger.tagged "GroupMembership #{id}" do
      group.roles.each do |r|
        logger.info "Granting role (#{r.id}, #{r.token}, App ID #{r.application_id}) to new group member (#{entity.id}/#{entity.name} joining #{group.id}/#{group.name})"
        ra = RoleAssignment.new
        ra.role_id = r.id
        ra.entity_id = entity.id
        ra.parent_id = group.id
        ra.save!
      end
    end
  end
  
  def remove_group_roles_from_member
    Rails.logger.tagged "GroupMembership #{id}" do
      group.roles.each do |r|
        logger.info "Removing role (#{r.id}, #{r.token}, App ID #{r.application_id}) from leaving group member (#{entity.id}/#{entity.name} leaving #{group.id}/#{group.name})"
        ra = RoleAssignment.find_by_role_id_and_entity_id_and_parent_id(r.id, entity.id, group.id)
        if ra
          destroying_calculated_role_assignment do
            ra.destroy
          end
        else
          logger.warn "Failed to remove role (#{r.id}, #{r.token}, App ID #{r.application_id}) assigned to leaving group member (#{entity.id}/#{entity.name}. Could not find in database. This is probably okay."
        end
      end
    end
  end
  
  def membership_cannot_be_cyclical
    
  end

  # Ensure a group does not attempt to join (member) itself
  def group_cannot_join_itself
    if !group.blank? and group == entity
      errors[:base] << "Group cannot join with itself"
    end
  end
  
  def destroying_calculated_membership_requires_flag
    if calculated and not @@destroy_calculated_membership_flag
      errors.add(:calculated, "can't destroy a calculated group membership without flag properly set")
      return false
    end
  end
end
