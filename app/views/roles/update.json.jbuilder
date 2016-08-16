json.cache! ['roles_update', @cache_key] do
  json.assignments @role.role_assignments.select{ |a| a.entity.active == true } do |assignment|
    json.extract! assignment, :id, :entity_id
    json.type assignment.entity.type
    json.name assignment.entity.name
    json.calculated assignment.parent_id != nil
  end
end
