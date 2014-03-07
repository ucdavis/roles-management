json.cache! ['api_v1_entities_index', @cache_key] do
  json.array!(@entities) do |entity|
    json.extract! entity, :id, :loginid, :name, :type
    
    # Use case: member_count is used by DSS Messenger's entity search
    json.member_count (defined? entity.memberships) ? entity.memberships.length : nil
  end
end