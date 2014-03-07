json.cache! ['v1', @cache_key] do
  json.array!(@role_assignments) do |assignment|
    json.extract! assignment, :parent_id, :id, :role_id, :entity_id
  end
end
