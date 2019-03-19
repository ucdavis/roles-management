class RolesService
  def self.create_role(application_id, name, token, description, ad_path)
    raise 'Expected String object' unless name.is_a?(String)
    raise 'Expected String object' unless token.is_a?(String)

    r = Role.new
    r.application_id = application_id
    r.name = name
    r.token = token
    r.description = description
    r.ad_path = ad_path
    r.save!

    return r
  end

  def self.destroy_role(role)
    raise 'Expected Role object' unless role.is_a?(Role)

    # Before destroying a role, destroy any role assignments associated with it
    role.role_assignments.each do |ra|
      RoleAssignmentsService.unassign_role_from_entity(ra)
    end

    role.destroy!
  end
end
