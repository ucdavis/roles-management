json.cache! ['api_v1_roles_show', @cache_key] do
  json.extract! @role, :id, :application_id, :description, :name, :token

  json.role_assignments_attributes @role.role_assignments.select{ |r| r.entity.active == true } do |assignment|
    json.extract! assignment, :id, :entity_id, :role_id
    json.extract! assignment.entity, :loginid, :name
  end
end
