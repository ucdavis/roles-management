json.extract! person, :id, :name, :loginid, :email, :type, :active, :address, :byline, :first, :last, :phone

json.role_assignments(person.role_assignments) do |role_assignment|
  json.extract! role_assignment, :id, :entity_id, :role_id
  json.calculated role_assignment.parent_id?
  json.token role_assignment.role.token
  json.application_name role_assignment.role.application.name
  json.application_id role_assignment.role.application_id
  json.name role_assignment.role.name
  json.description role_assignment.role.description
  json.role_id role_assignment.role.id
  json.id role_assignment.id
  json.entity_id role_assignment.entity_id
end

json.favorites(person.favorite_relationships.select { |f| f.entity.active == true }) do |favorite|
  # FIXME: Update JS code to use entity_id and let favorite.id be the person_favorite_assignment_id. JS code currently expects 'id' to refer to entity.id but this is confusing.
  json.id favorite.entity.id
  json.name favorite.entity.name
  json.type favorite.entity.type
end

json.groups_via_rules person.groups(only_via_rules = true) do |group|
  json.group_id group.id
  json.group_name group.name
end

json.group_memberships person.group_memberships do |membership|
  json.group_id membership.group_id
  json.group_name membership.group.name
  json.id membership.id
  json.name membership.group.name
end

json.group_operatorships person.group_operatorships do |operatorship|
  json.group_id operatorship.group_id
  json.id operatorship.id
  json.name operatorship.group.name
  json.group_name operatorship.group.name
end

json.group_ownerships person.group_ownerships do |ownership|
  json.group_id ownership.group_id
  json.id ownership.id
  json.name ownership.group.name
end
