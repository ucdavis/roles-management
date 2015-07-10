# GroupMembership may be calculated, in which case they need to be destroyed only by the proper method,
# e.g. through a group and not a person. A group accomplishes this by using the destroying_calculated_group_membership do ... end
# block method below.
class GroupMembership < ActiveRecord::Base
  using_access_control

  Thread.current[:destroy_calculated_membership_flag] = false
  Thread.current[:recalculating_membership_flag] = false

  def self.destroy_calculated_membership_flag=(val)
    Thread.current[:destroy_calculated_membership_flag] = val
  end
  def self.recalculating_membership_flag=(val)
    Thread.current[:recalculating_membership_flag] = val
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
  before_destroy :remove_group_roles_from_member

  after_create :grant_application_operatorships_to_member
  before_destroy :remove_application_operatorships_from_member

  after_save { |membership| membership.log_changes(:save) }
  after_destroy { |membership| membership.log_changes(:destroy) }

  def self.destroying_calculated_group_membership
    begin
      Thread.current[:destroy_calculated_membership_flag] = true
      yield
    ensure
      Thread.current[:destroy_calculated_membership_flag] = false
    end
  end
  def self.recalculating_membership
    begin
      Thread.current[:recalculating_membership_flag] = true
      yield
    ensure
      Thread.current[:recalculating_membership_flag] = false
    end
  end

  protected

  # Explicitly log that this group membership was created or destroyed
  def log_changes(action)
    Rails.logger.tagged "GroupMembership #{id}" do
      case action
      when :save
        if created_at_changed?
          logger.info "Created membership between #{entity.log_identifier} and #{group.log_identifier}."
          ActivityLog.info!("Added #{entity.name} to #{group.name}.", ["#{entity.type.downcase}_#{entity.id}", "group_#{group.id}"])
        else
          # RoleAssignments should really only be created or destroyed, not updated.
          logger.error "log_changes called for existing GroupMembership. This shouldn't happen. Membership is between #{entity.log_identifier} and #{group.log_identifier}."
        end
      when :destroy
        logger.info "Removed membership between #{entity.log_identifier} and #{group.log_identifier}."
        ActivityLog.info!("Removed #{entity.name} from #{group.name}.", ["#{entity.type.downcase}_#{entity.id}", "group_#{group.id}"])
      else
        logger.warn "Unknown action in log_changes #{action}."
      end
    end
  end

  private

  def membership_cannot_be_cyclical
    if entity.type == 'Group'
      if entity.no_loops_in_group_membership_graph([group_id]) == false
        errors.add(:base, "group memberships cannot form loop in membership tree graph")
      end
    end
  end

  # Grant group's roles to new member (marking as calculated)
  def grant_group_roles_to_member
    Rails.logger.tagged "GroupMembership #{id}" do
      # Our auth rules are not complex enough for the case where an operator adds
      # a group member causing that member to gain the group's roles but the operator
      # in question does not have permission to create those role assignments.
      # For this reason, we assume recursive group member-based role granting/revoking
      # can be safely done without authorization rules.
      previous_access_control = Authorization.ignore_access_control
      Authorization.ignore_access_control(true)
      group.roles.each do |r|
        logger.info "Granting role (#{r.id}, #{r.token}, App ID #{r.application_id}) to new group member (#{entity.id}/#{entity.name} joining #{group.id}/#{group.name})"
        ra = RoleAssignment.new
        ra.role_id = r.id
        ra.entity_id = entity.id
        ra.parent_id = group.id
        ra.save!
      end
      Authorization.ignore_access_control(previous_access_control)
    end

    return true
  end

  def remove_group_roles_from_member
    Rails.logger.tagged "GroupMembership #{id}" do
      # Our auth rules are not complex enough for the case where an operator adds
      # a group member causing that member to gain the group's roles but the operator
      # in question does not have permission to create those role assignments.
      # For this reason, we assume recursive group member-based role granting/revoking
      # can be safely done without authorization rules.
      previous_access_control = Authorization.ignore_access_control
      Authorization.ignore_access_control(true)
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
      Authorization.ignore_access_control(previous_access_control)
    end

    return true
  end

  # Ensure a group does not attempt to join (member) itself
  def group_cannot_join_itself
    if !group.blank? and group == entity
      errors[:base] << "Group cannot join with itself"
    end
  end

  def destroying_calculated_membership_requires_flag
    if calculated and not Thread.current[:destroy_calculated_membership_flag]
      errors.add(:calculated, "can't destroy a calculated group membership without flag properly set")
      return false
    end
  end

  # Grant group's application operatorships to new member (marking as calculated)
  def grant_application_operatorships_to_member
    Rails.logger.tagged "GroupMembership #{id}" do
      group.application_operatorships.each do |ao|
        logger.info "Granting application operatorship (#{ao.id}, App ID #{ao.application_id}) to new group member (#{entity_id}/#{entity.name} joining #{group_id}/#{group.name})"
        new_ao = ApplicationOperatorship.new
        new_ao.application_id = ao.application_id
        new_ao.entity_id = entity_id
        new_ao.parent_id = group_id
        new_ao.save!
      end
    end
  end

  def remove_application_operatorships_from_member
    Rails.logger.tagged "GroupMembership #{id}" do
      group.application_operatorships.each do |ao|
        logger.info "Removing application operatorship (#{ao.id}, App ID #{ao.application_id}) from leaving group member (#{entity_id}/#{entity.name} leaving #{group_id}/#{group.name})"
        inherited_ao = ApplicationOperatorship.find_by_application_id_and_entity_id_and_parent_id(ao.application_id, entity_id, group_id)
        if inherited_ao
          destroying_calculated_application_operatorship do
            inherited_ao.destroy
          end
        else
          logger.warn "Failed to remove application operatorship (#{ao.id}, App ID #{ao.application_id}) assigned to leaving group member (#{entity_id}/#{entity.name}. Could not find in database. This is probably okay."
        end
      end
    end
  end
end
