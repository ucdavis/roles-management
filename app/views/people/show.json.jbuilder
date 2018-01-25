json.cache! ['people_show', @cache_key] do
  json.extract! @person, :id, :name, :loginid, :email, :type

  json.role_assignments(@person.role_assignments) do |role_assignment|
    json.extract! role_assignment, :id, :entity_id, :role_id
    json.calculated role_assignment.parent_id?
    json.token role_assignment.role.token
    json.application_name role_assignment.role.application.name
    json.application_id role_assignment.role.application_id
    json.name role_assignment.role.name
    json.description role_assignment.role.description
  end
end
