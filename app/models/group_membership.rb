# GroupMembership may be calculated, in which case they need to be destroyed only by the proper method,
# e.g. through a group and not a person. A group accomplishes this by using the destroying_calculated_group_membership do ... end
# block method below.
class GroupMembership < ActiveRecord::Base
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
  validate :members_cannot_be_other_groups
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

  # Used by the valid case of Person.destroy being called. It is not correct
  # to destroy a group membership outside of a group (i.e. a person cannot just
  # destroy a single calculated group membership because they don't want it)
  # unless it is the case that a person is being destroyed, in which case
  # their group membership is useless anyway.
  def self.can_destroy_calculated_group_membership(flag)
    Thread.current[:destroy_calculated_membership_flag] = flag
  end

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
          # Only log group membership creation if this is the first time they've gained membership with this group
          if entity.group_memberships.map{|gm| gm.group.id}.count {|group_id| group_id == group.id } == 1
            logger.info "Created redundant-type membership between #{entity.log_identifier} and #{group.log_identifier}."
            ActivityLog.info!("Added #{entity.name} to group #{group.name}.", ["#{entity.type.downcase}_#{entity.id}", "group_#{group.id}"])
          end
        else
          # RoleAssignments should really only be created or destroyed, not updated.
          logger.error "log_changes called for existing GroupMembership. This shouldn't happen. Membership is between #{entity.log_identifier} and #{group.log_identifier}."
        end
      when :destroy
        if entity
          unless entity.group_memberships.map{|gm| gm.group.id}.include? group.id
            # Only log group membership destruction if they're losing the last association to this group
            logger.info "Removed redundant-type membership between #{entity.log_identifier} and #{group.log_identifier}."
            ActivityLog.info!("Removed #{entity.name} from group #{group.name}.", ["#{entity.type.downcase}_#{entity.id}", "group_#{group.id}"])
          end
        else
          logger.error "Asked to remove membership involving an entity that was null. GroupMembership is #{id}. Entity ID should be #{entity_id}"
        end
      else
        logger.warn "Unknown action in log_changes #{action}."
      end
    end
  end

  private

  def members_cannot_be_other_groups
    if entity && entity.type == 'Group'
      errors.add(:base, "groups cannot be members of other groups")
    end
  end

  # Grant group's roles to new member (marking as calculated)
  def grant_group_roles_to_member
    Rails.logger.tagged "GroupMembership #{id}" do
      group.role_assignments.each do |ra|
        logger.info "Granting role (#{ra.role_id}, #{ra.role.token}, App ID #{ra.role.application_id}) to new group member (#{entity.id}/#{entity.name} joining #{group.id}/#{group.name})"
        member_ra = RoleAssignment.new
        member_ra.role_id = ra.role_id
        member_ra.entity_id = entity.id
        member_ra.parent_id = ra.id
        member_ra.save!
      end
    end

    return true
  end

  def remove_group_roles_from_member
    Rails.logger.tagged "GroupMembership #{id}" do
      group.role_assignments.each do |ra|
        if entity
          logger.info "Removing role (#{ra.role_id}, #{ra.role.token}, App ID #{ra.role.application_id}) from leaving group member (#{entity.id}/#{entity.name} leaving #{group.id}/#{group.name})"
          member_ra = RoleAssignment.find_by_role_id_and_entity_id_and_parent_id(ra.role_id, entity.id, ra.id)
          if member_ra
            destroying_calculated_role_assignment do
              member_ra.destroy!
            end
          else
            logger.warn "Failed to remove role (#{ra.role_id}, #{ra.role.token}, App ID #{ra.role.application_id}) assigned to leaving group member (#{entity.id}/#{entity.name}. Could not find in database."
          end
        else
          logger.error "Asked to remove role for leaving group member but member is non-existent. Entity ID should be #{entity_id}"
        end
      end
    end

    return true
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
        new_ao.parent_id = ao.id
        new_ao.save!
      end
    end
  end

  def remove_application_operatorships_from_member
    Rails.logger.tagged "GroupMembership #{id}" do
      group.application_operatorships.each do |ao|
        logger.info "Removing application operatorship (#{ao.id}, application ID #{ao.application_id}) from leaving group member (#{entity_id}/#{entity.name} leaving #{group_id}/#{group.name})"
        inherited_ao = ApplicationOperatorship.find_by_application_id_and_entity_id_and_parent_id(ao.application_id, entity_id, ao.id)
        if inherited_ao
          destroying_calculated_application_operatorship do
            inherited_ao.destroy!
          end
        else
          logger.warn "Failed to remove application operatorship (#{ao.id}, App ID #{ao.application_id}) assigned to leaving group member (#{entity_id}/#{entity.name}. Could not find in database."
        end
      end
    end
  end
end
