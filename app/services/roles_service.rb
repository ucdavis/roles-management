class RolesService
  def self.create_role(application_id, name, token, description, ad_path)
    raise 'Expected String object' unless name.is_a?(String)
    raise 'Expected String object' unless token.is_a?(String)

    role = Role.new
    role.application_id = application_id
    role.name = name
    role.token = token
    role.description = description
    role.ad_path = ad_path
    role.save!

    if role.application.name == "DocuSign" && !(Integer(token) rescue false)
      Docusign.configure
      response = Docusign.create_groups(Array(role.name))
      
      role.token = response.groups.first.group_id
      role.save!
    end

    ActivityLog.info!("Created role #{role.name} (#{role.token}).", ["application_#{role.application_id}"])

    return role
  end

  # Updates a role with the given parameters, returning true only if the role changed.
  def self.update_role(role, name, token, description, ad_path)
    raise 'Expected Role object' unless role.is_a?(Role)
    raise 'Expected String object' unless name.is_a?(String)
    raise 'Expected String object' unless token.is_a?(String)

    role.name = name
    role.token = token
    role.description = description.presence && description
    role.ad_path = ad_path.presence && ad_path

    if role.changed?
      if role.application.name == "DocuSign"
        Docusign.configure
        Docusign.update_group(role.token, role.name)
      end

      role.save!

      # Notify sync about changes to the role
      Sync.role_changed(Sync.encode(role).merge(changes: role.saved_changes.select { |c, _v| %w[ad_path token name description].include?(c) }))

      return true
    else
      return false
    end
  end

  def self.destroy_role(role)
    raise 'Expected Role object' unless role.is_a?(Role)

    # Before destroying a role, destroy any role assignments associated with it
    role.role_assignments.each do |ra|
      RoleAssignmentsService.unassign_role_from_entity(ra)
    end

    if role.application.name == "DocuSign"
      Docusign.configure
      Docusign.delete_group_by_id(role.token)
    end

    role.destroy!

    ActivityLog.info!("Deleted role #{role.token}.", ["application_#{role.application_id}"])
  end
end
