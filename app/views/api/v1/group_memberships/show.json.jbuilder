json.cache! ['api_v1_group_memberships_show', @cache_key] do
  json.extract! @group_membership, :id, :entity_id, :calculated, :group_id
end
