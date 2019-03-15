class RoleAssignmentsService
  def self.assign_role_to_group(group, role)
    raise 'Expected Group object' unless group.is_a?(Group)
    raise 'Expected Role object' unless role.is_a?(Role)

    # Assign role to group
    ra = RoleAssignment.new
    ra.role_id = role.id
    ra.entity_id = group.id
    ra.parent_id = nil
    ra.save!

    # Ensure group members inherit role
    group.reload
    group.members.each do |member|
      self._inherit_role_assignment(ra, member)
    end
  end

  # Assign group roles to all members of a group
  def self.assign_group_roles_to_members(group)
    raise 'Expected Group object' unless group.is_a?(Group)

    group.role_assignments.each do |role_assignment|
      self.assign_group_role_assignment_to_members(group, role_assignment)
    end
  end

  def self.assign_group_role_assignment_to_members(group, role_assignment)
    raise 'Expected Group object' unless group.is_a?(Group)
    raise 'Expected RoleAssignment object' unless role_assignment.is_a?(RoleAssignment)
    raise 'Expected RoleAssignment to belong to Group' unless role_assignment.entity_id == group.id

    group.members.each do |member|
      self._inherit_role_assignment(role_assignment, member)
    end
  end

  # Assign group roles to the given member of the group
  def self.assign_group_roles_to_member(group, member)
    raise 'Expected Group object' unless group.is_a?(Group)
    raise 'Expected Person object' unless member.is_a?(Person)

    group.role_assignments.each do |role_assignment|
      self._inherit_role_assignment(role_assignment, member)
    end
  end

  # Creates a role assignment inherited from another
  def self._inherit_role_assignment(role_assignment, person)
    role = role_assignment.role

    if RoleAssignment.find_by(role_id: role.id, entity_id: person.id, parent_id: role_assignment.id)
      Rails.logger.info "Not inheriting role (#{role.id}, #{role.token}, #{role.application.name}) for person (#{person.id}/#{person.name}), already exists."
    else
      Rails.logger.info "Inheriting role (#{role.id}, #{role.token}, #{role.application.name}) for person (#{person.id}/#{person.name})"

      ra = RoleAssignment.new
      ra.role_id = role.id
      ra.entity_id = person.id
      ra.parent_id = role_assignment.id
      ra.save!
    end
  end

  # Removes a role assignment inherited from another
  def self._uninherit_role_assignment(role_assignment, person)
    role = role_assignment.role

    inherited_ra = RoleAssignment.find_by(entity_id: person.id, parent_id: role_assignment.id)

    if inherited_ra
      role = inherited_ra.role
      Rails.logger.info "Unassigning inherited role (#{role.id}, #{role.token}, #{role.application.name}) from person (#{person.id}/#{person.name})"
      inherited_ra.destroy!
    else
      role = role_assignment.role
      Rails.logger.info "Not unassigning inherited role (#{role.id}, #{role.token}, #{role.application.name}) from person (#{person.id}/#{person.name}), does not exist"
    end
  end

  # Unassign group roles to the given member of the group
  def self.unassign_group_roles_from_member(group, member)
    raise 'Expected Group object' unless group.is_a?(Group)
    raise 'Expected Person object' unless member.is_a?(Person)

    group.role_assignments.each do |role_assignment|
      self._uninherit_role_assignment(role_assignment, member)
    end
  end

  def self.unassign_group_role_assignment_from_members(group, role_assignment)
    raise 'Expected Group object' unless group.is_a?(Group)
    raise 'Expected RoleAssignment object' unless role_assignment.is_a?(RoleAssignment)
    raise 'Expected RoleAssignment to belong to Group' unless role_assignment.entity_id == group.id

    group.members.each do |member|
      self._uninherit_role_assignment(role_assignment, member)
    end
  end
end
