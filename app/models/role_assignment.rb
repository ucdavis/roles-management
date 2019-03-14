require 'sync'

class RoleAssignment < ApplicationRecord
  include Immutable

  belongs_to :role, touch: true
  belongs_to :entity, touch: true

  validates :role, :entity, presence: true
  validate :parent_must_exist_if_set

  # Though this seems like 'group' logic, it must be done in this 'join table' class
  # as role assignments can be created by e.g. saving an application with roles_attributes
  # and modifying a role's entity_ids, meaning these callbacks would work but
  # the Group being assigned would never have its callbacks used
  after_create :grant_role_assignment_to_group_members_if_needed
  before_destroy :remove_role_assignment_from_group_members_if_needed

  # Trigger role syncs when role membership (assignment) changes.
  # Note: For a group which has a role and gains a new member, that group
  #       membership code will give them their own calculated RoleAssignment (parent_id),
  #       thereby triggering role sync.
  # Note: We skip over groups as their individual members hold their own role assignments which
  #       will catch any needed syncing.
  after_create do |assignment|
    # Only trigger person_added_to_role if this is the first time they gained the role
    if RoleAssignment.where(role_id: assignment.role_id, entity_id: assignment.entity_id).count == 1
      ActivityLog.info!("Added #{assignment.entity.name} to role (#{assignment.role.name_with_application}).", ["#{assignment.entity.type.downcase}_#{assignment.entity.id}", "application_#{assignment.role.application_id}"])
      unless assignment.entity.type == 'Group'
        Sync.person_added_to_role(Sync.encode(assignment.entity), Sync.encode(assignment.role)) if assignment.entity.active
      end
    end
  end
  after_destroy do |assignment|
    # Only trigger person_removed_from_role if they lost this role entirely (they may the role through
    # multiple means such as a group assignment)
    unless RoleAssignment.find_by(role_id: assignment.role_id, entity_id: assignment.entity_id)
      ActivityLog.info!("Removed #{assignment.entity.name} from role (#{assignment.role.name_with_application}).", ["#{assignment.entity.type.downcase}_#{assignment.entity.id}", "application_#{assignment.role.application_id}"])
      unless assignment.entity.type == 'Group'
        Sync.person_removed_from_role(Sync.encode(assignment.entity), Sync.encode(assignment.role)) if assignment.entity.active
      end
    end
  end

  after_save { |assignment| assignment.log_changes(:save) }
  after_destroy { |assignment| assignment.log_changes(:destroy) }

  protected

  # Explicitly log that this role assignment was created or destroyed
  def log_changes(action)
    Rails.logger.tagged "RoleAssignment #{id}" do
      case action
      when :save
        if saved_change_to_attribute?(:created_at)
          logger.info "Created redundant-type assignment between #{entity.log_identifier} and #{role.log_identifier}."
        end
      when :destroy
        logger.info "Removed redundant-type assignment between #{entity.log_identifier} and #{role.log_identifier}."
      end
    end
  end

  private

  # Grant this role assignment to all members of the group
  # (only if this role assignment really is with a group)
  def grant_role_assignment_to_group_members_if_needed
    return unless entity.type == 'Group'

    Rails.logger.tagged "RoleAssignment #{id}" do
      entity.members.each do |m|
        logger.info "Granting role (#{role.id}, #{role.token}, #{role.application.name}) just granted to group (#{entity.id}/#{entity.name}) to its member (#{m.id}/#{m.name})"
        ra = RoleAssignment.new
        ra.role_id = role.id
        ra.entity_id = m.id
        ra.parent_id = id
        ra.save!
      end
    end
  end

  # Remove this role assignment from all members of the group
  # (only if this role assignment really was with a group)
  def remove_role_assignment_from_group_members_if_needed
    return unless entity.type == 'Group'

    Rails.logger.tagged "RoleAssignment #{id}" do
      entity.members.each do |m|
        logger.info "Removing role (#{role.id}, #{role.token}, #{role.application.name}) about to be removed from group (#{entity.id}/#{entity.name} from its member #{m.id}/#{m.name})"
        ra = RoleAssignment.find_by_role_id_and_entity_id_and_parent_id(role.id, m.id, self.id)
        if ra
          ra.destroy!
        else
          logger.warn "Failed to remove role (#{role.id}, #{role.token}, #{role.application.name}) assigned to group member (#{m.id}/#{m.name}) which needs to be removed as the group (#{entity.id}/#{entity.name}) is losing that role."
        end
      end
    end
  end

  def parent_must_exist_if_set
    if parent_id && RoleAssignment.find_by_id(parent_id).nil?
      errors.add(:parent_id, 'parent_id must be a valid RoleAssignment')
      return false # rubocop:disable Style/RedundantReturn
    end
  end
end
