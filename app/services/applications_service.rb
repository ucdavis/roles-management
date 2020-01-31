class ApplicationsService
  def self.grant_application_ownership(application, entity, parent_application_ownership_id = nil)
    raise 'Expected Application object' unless application.is_a?(Application)
    raise 'Expected Entity object' unless entity.is_a?(Entity)

    ao = ApplicationOwnership.new
    ao.application_id = application.id
    ao.entity_id = entity.id
    ao.parent_id = parent_application_ownership_id
    ao.save!

    Rails.logger.info "Created application ownership between #{entity.log_identifier} and #{application.log_identifier}"

    # If entity is a group, ensure group members inherit application ownership
    # (Groups cannot inherit application ownerships, so there is no need to propogate them to group members)
    if entity.group? && (parent_application_ownership_id == nil)
      grant_application_ownership_to_group_members(application, entity)
    end
  end

  def self.revoke_application_ownership(application_ownership)
    raise 'Expected ApplicationOwnership object' unless application_ownership.is_a?(ApplicationOwnership)

    entity = application_ownership.entity
    application = application_ownership.application

    if entity.group?
      remove_application_ownership_from_group_members(application_ownership.application, entity)
    end

    application_ownership.destroy!

    Rails.logger.info "Removed application ownership between #{entity.log_identifier} and #{application.log_identifier}"
  end

  # Grant this application ownership to all members of the group
  # (iff group ownership is with a group)
  def self.grant_application_ownership_to_group_members(application, group)
    raise 'Expected Application object' unless application.is_a?(Application)
    raise 'Expected Group object' unless group.is_a?(Group)

    parent_ao = find_application_ownership_by_application_and_group(application, group)
    if parent_ao == nil
      Rails.logger.warn "Expected to find ApplicationOwnership for application (ID: #{application.id}) by group (ID: #{group.id}) but did not. Ignoring ..."
      return
    end

    group.members.each do |m|
      Rails.logger.info "Granting application ownership (AO ID: #{parent_ao.id}, #{application.name}) granted to group (#{group.id}/#{group.name}) to its member (#{m.id}/#{m.name})"
      grant_application_ownership(application, m, parent_ao.id)
    end
  end

  # Remove this application ownership from all members of the group
  # (iff group ownership is with a group)
  def self.remove_application_ownership_from_group_members(application, group)
    raise 'Expected Application object' unless application.is_a?(Application)
    raise 'Expected Group object' unless group.is_a?(Group)

    parent_ao = find_application_ownership_by_application_and_group(application, group)
    if parent_ao == nil
      Rails.logger.warn "Expected to find ApplicationOwnership for application (ID: #{application.id}) by group (ID: #{group.id}) but did not. Ignoring ..."
      return
    end

    group.members.each do |m|
      ao = ApplicationOwnership.find_by(application_id: application.id, entity_id: m.id, parent_id: parent_ao.id)
      if ao
        Rails.logger.info "Removing child application ownership (AO ID: #{ao.id}, #{application.name}) from member #{m.id}/#{m.name}) of group (#{group.id}/#{group.name}"
        revoke_application_ownership(ao)
      else
        Rails.logger.warn "Failed to remove application ownership (#{id}, #{application.name}) assigned to group member (#{m.id}/#{m.name}) which needs to be removed as the group (#{entity.id}/#{entity.name}) is losing that ownership."
      end
    end
  end

  def self.grant_application_operatorship(application, entity, parent_application_operatorship_id = nil)
    raise 'Expected Application object' unless application.is_a?(Application)
    raise 'Expected Entity object' unless entity.is_a?(Entity)

    ao = ApplicationOperatorship.new
    ao.application_id = application.id
    ao.entity_id = entity.id
    ao.parent_id = parent_application_operatorship_id
    ao.save!

    Rails.logger.info "Created application operatorship between #{entity.log_identifier} and #{application.log_identifier}"

    # If entity is a group, ensure group members inherit application operatorship
    # (Groups cannot inherit application operatorships, so there is no need to propogate them to group members)
    if entity.group? && (parent_application_operatorship_id == nil)
      grant_application_operatorship_to_group_members(application, entity)
    end
  end

  def self.revoke_application_operatorship(application_operatorship)
    raise 'Expected ApplicationOperatorship object' unless application_operatorship.is_a?(ApplicationOperatorship)

    entity = application_operatorship.entity
    application = application_operatorship.application

    if entity.group?
      remove_application_operatorship_from_group_members(application_operatorship.application, entity)
    end

    application_operatorship.destroy!

    Rails.logger.info "Removed application operatorship between #{entity.log_identifier} and #{application.log_identifier}"
  end

  # Grant this application operatorship to all members of the group
  # (iff group operatorship is with a group)
  def self.grant_application_operatorship_to_group_members(application, group)
    raise 'Expected Application object' unless application.is_a?(Application)
    raise 'Expected Group object' unless group.is_a?(Group)

    parent_ao = find_application_operatorship_by_application_and_group(application, group)
    if parent_ao == nil
      Rails.logger.warn "Expected to find ApplicationOperatorship for application (ID: #{application.id}) by group (ID: #{group.id}) but did not. Ignoring ..."
      return
    end

    group.members.each do |m|
      Rails.logger.info "Granting application operatorship (AO ID: #{parent_ao.id}, #{application.name}) granted to group (#{group.id}/#{group.name}) to its member (#{m.id}/#{m.name})"
      grant_application_operatorship(application, m, parent_ao.id)
    end
  end

  # Remove this application operatorship from all members of the group
  # (iff group operatorship is with a group)
  def self.remove_application_operatorship_from_group_members(application, group)
    raise 'Expected Application object' unless application.is_a?(Application)
    raise 'Expected Group object' unless group.is_a?(Group)

    parent_ao = find_application_operatorship_by_application_and_group(application, group)
    if parent_ao == nil
      Rails.logger.warn "Expected to find ApplicationOperatorship for application (ID: #{application.id}) by group (ID: #{group.id}) but did not. Ignoring ..."
      return
    end

    group.members.each do |m|
      ao = ApplicationOperatorship.find_by(application_id: application.id, entity_id: m.id, parent_id: parent_ao.id)
      if ao
        Rails.logger.info "Removing child application operatorship (AO ID: #{ao.id}, #{application.name}) from member #{m.id}/#{m.name}) of group (#{group.id}/#{group.name}"
        revoke_application_operatorship(ao)
      else
        Rails.logger.warn "Failed to remove application operatorship (#{id}, #{application.name}) assigned to group member (#{m.id}/#{m.name}) which needs to be removed as the group (#{entity.id}/#{entity.name}) is losing that operatorship."
      end
    end
  end

  private

  def self.find_application_ownership_by_application_and_group(application, group)
    ApplicationOwnership.find_by(application_id: application.id, entity_id: group.id, parent_id: nil)
  end

  def self.find_application_operatorship_by_application_and_group(application, group)
    ApplicationOperatorship.find_by(application_id: application.id, entity_id: group.id, parent_id: nil)
  end
end
