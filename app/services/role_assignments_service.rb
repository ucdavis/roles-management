class RoleAssignmentsService
  def self.assign_role_to_entity(entity, role, parent_role_assignment_id = nil)
    raise 'Expected Entity object' unless entity.is_a?(Entity)
    raise 'Expected Role object' unless role.is_a?(Role)

    # Assign role to group
    ra = RoleAssignment.new
    ra.role_id = role.id
    ra.entity_id = entity.id
    ra.parent_id = parent_role_assignment_id
    ra.save!

    Rails.logger.info "Created role assignment between #{entity.log_identifier} (entitiy ID: #{entity.id}) and #{role.log_identifier} (role ID: #{role.id})"

    # Trigger person_added_to_role if this is the first time gaining the role
    if RoleAssignment.where(role_id: role.id, entity_id: entity.id).count == 1
      ActivityLog.info!("Added #{entity.name} to role (#{role.name_with_application}).", ["#{entity.type.downcase}_#{entity.id}", "application_#{role.application_id}"])
      unless entity.type == 'Group'
        Sync.person_added_to_role(Sync.encode(entity), Sync.encode(role)) if entity.active
      end
    end

    # If entity is a group, ensure group members inherit role
    # (Groups cannot inherit roles, so there is no need to propogate inherited roles to group members)
    if entity.is_a?(Group) && (parent_role_assignment_id == nil)
      entity.reload
      entity.members.each do |member|
        _inherit_role_assignment(ra, member)
      end
    end

    return ra
  end

  def self.unassign_role_from_entity(role_assignment)
    raise 'Expected RoleAssignment object' unless role_assignment.is_a?(RoleAssignment)

    entity = role_assignment.entity
    role = role_assignment.role

    # If entity is a group, ensure group members lose inherited role, if applicable
    if entity.is_a?(Group)
      unassign_group_role_assignment_from_members(entity, role_assignment)
    end

    role_assignment.destroy!

    Rails.logger.info "Removed role assignment between #{entity.log_identifier} and #{role.log_identifier}"

    # Trigger person_removed_from_role if they lost this role entirely
    # (They may the role through multiple means such as a group assignment)
    unless RoleAssignment.find_by(role_id: role.id, entity_id: entity.id)
      ActivityLog.info!("Removed #{entity.name} from role (#{role.name_with_application}).", ["#{entity.type.downcase}_#{entity.id}", "application_#{role.application_id}"])
      unless entity.type == 'Group'
        Sync.person_removed_from_role(Sync.encode(entity), Sync.encode(role)) if entity.active
      end
    end
  end

  # Assign group roles to all members of a group
  def self.assign_group_roles_to_members(group)
    raise 'Expected Group object' unless group.is_a?(Group)

    group.role_assignments.each do |role_assignment|
      assign_group_role_assignment_to_members(group, role_assignment)
    end
  end

  def self.assign_group_role_assignment_to_members(group, role_assignment)
    raise 'Expected Group object' unless group.is_a?(Group)
    raise 'Expected RoleAssignment object' unless role_assignment.is_a?(RoleAssignment)
    raise 'Expected RoleAssignment to belong to Group' unless role_assignment.entity_id == group.id

    group.members.each do |member|
      _inherit_role_assignment(role_assignment, member)
    end
  end

  # Assign group roles to the given member of the group
  def self.assign_group_roles_to_member(group, member)
    raise 'Expected Group object' unless group.is_a?(Group)
    raise 'Expected Person object' unless member.is_a?(Person)

    group.role_assignments.each do |role_assignment|
      _inherit_role_assignment(role_assignment, member)
    end
  end

  # Unassign group roles to the given member of the group
  def self.unassign_group_roles_from_member(group, member)
    raise 'Expected Group object' unless group.is_a?(Group)
    raise 'Expected Person object' unless member.is_a?(Person)

    group.role_assignments.each do |role_assignment|
      _uninherit_role_assignment(role_assignment, member)
    end
  end

  def self.unassign_group_role_assignment_from_members(group, role_assignment)
    raise 'Expected Group object' unless group.is_a?(Group)
    raise 'Expected RoleAssignment object' unless role_assignment.is_a?(RoleAssignment)
    raise 'Expected RoleAssignment to belong to Group' unless role_assignment.entity_id == group.id

    group.members.each do |member|
      _uninherit_role_assignment(role_assignment, member)
    end
  end

  private

  # Creates a role assignment inherited from another
  def self._inherit_role_assignment(role_assignment, person)
    role = role_assignment.role

    if RoleAssignment.find_by(role_id: role.id, entity_id: person.id, parent_id: role_assignment.id)
      Rails.logger.info "Not inheriting role (#{role.id}, #{role.token}, #{role.application.name}) for person (#{person.id}/#{person.name}), already exists."
    else
      Rails.logger.info "Inheriting role (#{role.id}, #{role.token}, #{role.application.name}) for person (#{person.id}/#{person.name})"

      assign_role_to_entity(person, role, role_assignment.id)
    end
  end

  # Removes a role assignment inherited from another
  def self._uninherit_role_assignment(role_assignment, person)
    inherited_ra = RoleAssignment.find_by(entity_id: person.id, parent_id: role_assignment.id)

    if inherited_ra
      role = inherited_ra.role
      Rails.logger.info "Unassigning inherited role (#{role.id}, #{role.token}, #{role.application.name}) from person (#{person.id}/#{person.name})"
      unassign_role_from_entity(inherited_ra)
    else
      role = role_assignment.role
      Rails.logger.info "Not unassigning inherited role (#{role.id}, #{role.token}, #{role.application.name}) from person (#{person.id}/#{person.name}), does not exist"
    end
  end
end
