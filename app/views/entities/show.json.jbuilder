json.cache! ['entity_show', @cache_key] do
  json.extract! @entity, :id, :type, :name

  if @entity.type == 'Person'
    json.extract! @entity, :email, :active, :address, :byline, :first, :last, :loginid, :phone

    json.favorites(@entity.favorite_relationships.select { |f| f.entity.active == true }) do |favorite|
      json.id favorite.entity.id # FIXME: Update JS code to use entity_id and let favorite.id be the person_favorite_assignment_id. JS code currently expects 'id' to refer to entity.id but this is confusing.
      json.name favorite.entity.name
      json.type favorite.entity.type
    end

    json.groups_via_rules @entity.groups(only_via_rules = true) do |group|
      json.group_id group.id
      json.group_name group.name
    end

    json.group_memberships @entity.group_memberships do |membership|
      json.group_id membership.group_id
      json.group_name membership.group.name
      json.id membership.id
      json.name membership.group.name
    end

    json.group_operatorships @entity.group_operatorships do |operatorship|
      json.group_id operatorship.group_id
      json.id operatorship.id
      json.name operatorship.group.name
      json.group_name operatorship.group.name
    end

    json.group_ownerships @entity.group_ownerships do |ownership|
      json.group_id ownership.group_id
      json.id ownership.id
      json.name ownership.group.name
    end

    json.role_assignments @entity.role_assignments do |role_assignment|
      json.application_id role_assignment.role.application_id
      json.application_name role_assignment.role.application.name
      json.calculated role_assignment.parent_id?
      json.description role_assignment.role.description
      json.entity_id role_assignment.entity_id
      json.id role_assignment.id
      json.name role_assignment.role.name
      json.role_id role_assignment.role.id
      json.token role_assignment.role.token
    end
  elsif @entity.type == 'Group'
    json.extract! @entity, :description

    json.memberships @entity.memberships do |membership|
      json.id membership.id
      json.loginid membership.entity.loginid
      json.name membership.entity.name
      json.entity_id membership.entity_id
      json.active membership.entity.active
    end

    json.rule_members @entity.rule_members do |rule_member|
      json.loginid rule_member.loginid
      json.name rule_member.name
      json.person_id rule_member.id
      json.active rule_member.active
    end

    json.operators(@entity.operators.select { |m| m.active == true }) do |operator|
      json.extract! operator, :id, :name, :loginid
    end

    json.owners(@entity.owners.select { |m| m.active == true }) do |owner|
      json.extract! owner, :id, :name, :loginid
    end

    json.rules @entity.rules do |rule|
      json.extract! rule, :column, :condition, :value, :id
    end

    json.role_assignments @entity.role_assignments do |role_assignment|
      json.id role_assignment.id
      json.application_id role_assignment.role.application_id
      json.application_name role_assignment.role.application.name
      json.name role_assignment.role.name
      json.entity_id role_assignment.entity_id
      json.role_id role_assignment.role.id
      json.token role_assignment.role.token
    end
  end
end
