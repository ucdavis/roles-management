json.cache! ['role_assignments_show', @cache_key] do
  json.extract! @role_assignment, :id, :role_id, :entity_id, :parent_id
end
