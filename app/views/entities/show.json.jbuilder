json.cache! ['entity_show', @cache_key] do
  json.extract! @entity, :id, :type, :name

  if @entity.type == 'Person'
    json.extract! @entity, :email, :active, :address, :byline, :first, :last, :loginid, :phone

    json.favorites @entity.favorite_relationships.select{ |f| f.entity.active == true } do |favorite|
      json.id favorite.entity.id # FIXME: Update JS code to use entity_id and let favorite.id be the person_favorite_assignment_id. JS code currently expects 'id' to refer to entity.id but this is confusing.
      #json.entity_id favorite.entity.id
      json.name favorite.entity.name
      json.type favorite.entity.type
    end

    json.group_memberships @entity.group_memberships do |membership|
      json.calculated membership.calculated
      json.group_id membership.group_id
      json.id membership.id
      json.name membership.entity.name
    end

    json.group_operatorships @entity.group_operatorships do |operatorship|
      json.group_id operatorship.group_id
      json.id operatorship.id
      json.name operatorship.entity.name
    end

    json.group_ownerships @entity.group_ownerships do |ownership|
      json.group_id ownership.group_id
      json.id ownership.id
      json.name ownership.group.name
    end

    json.organizations @entity.organizations do |organization|
      json.id organization.id
      json.name organization.name
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

    json.memberships @entity.memberships.select{ |m| m.entity.active == true } do |membership|
      json.id membership.id
      json.calculated membership.calculated
      json.loginid membership.entity.loginid
      json.name membership.entity.name
      json.entity_id membership.entity_id
    end
    json.operators @entity.operators.select{ |m| m.active == true } do |operator|
      json.extract! operator, :id, :name, :loginid
    end
    json.owners @entity.owners.select{ |m| m.active == true } do |owner|
      json.extract! owner, :id, :name, :loginid
    end
    json.rules @entity.rules do |rule|
      json.extract! rule, :column, :condition, :value, :id
    end
  end
end
