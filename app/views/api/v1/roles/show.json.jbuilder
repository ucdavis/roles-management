json.cache! ['api_v1_roles_show', @cache_key] do
  json.extract! @role, :id, :application_id, :description, :name, :token

  json.role_assignments_attributes @role.role_assignments.select{ |r| r.entity.active == true } do |assignment|
    json.extract! assignment, :id, :entity_id, :role_id
    json.extract! assignment.entity, :loginid, :name, :email
  end

  # 'members' are the entities from role_assignments (above) but flattened
  # to include the people in a group instead of listing the group. Recurses
  # in the case of a group in a group, etc. The disadvantage is you do not
  # have the role assignment ID to perform a removal.
  json.members @role.members.select{ |m| m.active == true } do |member|
    json.extract! member, :id, :loginid, :name, :email
  end
end
