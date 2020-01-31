class GroupMembershipsService
  def self.assign_member_to_group(entity, group)
    raise 'Expected Entity object' unless entity.is_a?(Entity)
    raise 'Expected Group object' unless group.is_a?(Group)

    gm = GroupMembership.new
    gm.group_id = group.id
    gm.entity_id = entity.id
    gm.save!

    RoleAssignmentsService.assign_group_roles_to_member(group, entity)

    self.grant_group_application_operatorships_to_member(group, entity)

    # Log to Rails log, ActivityLog
    if entity.group_memberships.map { |gm| gm.group.id }.count { |group_id| group_id == group.id } == 1
      Rails.logger.info "Added #{entity.log_identifier} to group #{group.log_identifier}"
      ActivityLog.info!("Added #{entity.name} to group #{group.name}.", ["#{entity.type.downcase}_#{entity.id}", "group_#{group.id}"])
    end

    return gm
  end

  def self.remove_member_from_group(entity, group)
    raise 'Expected Entity object' unless entity.is_a?(Entity)
    raise 'Expected Group object' unless group.is_a?(Group)

    gm = GroupMembership.find_by(group_id: group.id, entity_id: entity.id)
    gm.destroy! if gm

    RoleAssignmentsService.unassign_group_roles_from_member(group, entity)

    self.remove_group_application_operatorships_from_member(group, entity)

    # Log to Rails log, ActivityLog
    unless entity.group_memberships.map{|gm| gm.group.id}.include? group.id
      # Only log group membership destruction if they're losing the last association to this group
      Rails.logger.info "Removed membership of #{entity.log_identifier} from group #{group.log_identifier}"
      ActivityLog.info!("Removed #{entity.name} from group #{group.name}.", ["#{entity.type.downcase}_#{entity.id}", "group_#{group.id}"])
    end
  end

  private

  def self.grant_group_application_operatorships_to_member(group, member)
    raise 'Expected Group object' unless group.is_a?(Group)

    group.application_operatorships.each do |ao|
      Rails.logger.info "Granting application operatorship (#{ao.id}, App ID #{ao.application_id}) to group member (#{member.id}/#{member.name} of group #{group.id}/#{group.name})"

      new_ao = ApplicationOperatorship.new
      new_ao.application_id = ao.application_id
      new_ao.entity_id = member.id
      new_ao.parent_id = ao.id

      new_ao.save!
    end
  end

  def self.remove_group_application_operatorships_from_member(group, member)
    raise 'Expected Group object' unless group.is_a?(Group)

    group.application_operatorships.each do |ao|
      Rails.logger.info "Removing application operatorship (#{ao.id}, application ID #{ao.application_id}) from group member (#{member.id}/#{member.name} of group #{group.id}/#{group.name})"
      inherited_ao = ApplicationOperatorship.find_by_application_id_and_entity_id_and_parent_id(ao.application_id, member.id, ao.id)
      if inherited_ao
        inherited_ao.destroy!
      else
        Rails.logger.warn "Failed to remove application operatorship (#{ao.id}, App ID #{ao.application_id}) from group member (#{member.id}/#{member.name}: could not find in database"
      end
    end
  end
end
