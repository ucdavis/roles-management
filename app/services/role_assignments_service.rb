class RoleAssignmentsService
  # Assign group roles to all members of a group
  def self.assign_group_roles_to_members(group)
    raise 'Expected Group object' unless group.is_a?(Group)

    group.role_assignments.each do |role_assignment|
      group.members.each do |member|
        self._inherit_role_assignment(role_assignment, member)
      end
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
      logger.info "Not inheriting role (#{role.id}, #{role.token}, #{role.application.name}) for person (#{person.id}/#{person.name}), already exists."
    else
      logger.info "Inheriting role (#{role.id}, #{role.token}, #{role.application.name}) for person (#{person.id}/#{person.name})"

      ra = RoleAssignment.new
      ra.role_id = role.id
      ra.entity_id = person.id
      ra.parent_id = role_assignment.id
      ra.save!
    end
end

  # Unassign group roles to the given member of the group
  def self.unassign_group_roles_from_member(group, member)
    raise 'Expected Group object' unless group.is_a?(Group)
    raise 'Expected Person object' unless member.is_a?(Person)

    group.role_assignments.each do |role_assignment|
      inherited_ra = RoleAssignment.find_by(entity_id: member.id, parent_id: role_assignment.id)

      if inherited_ra
        role = inherited_ra.role
        logger.info "Unassigning inherited role (#{role.id}, #{role.token}, #{role.application.name}) from group member (#{member.id}/#{member.name})"

        inherited_ra.destroy!
      else
        role = role_assignment.role
        logger.info "Not unassigning inherited role (#{role.id}, #{role.token}, #{role.application.name}) from group member (#{member.id}/#{member.name}), does not exist"
      end
    end
  end
end
