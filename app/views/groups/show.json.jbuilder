json.cache! ['groups_show', @cache_key] do
  json.partial! 'groups/show', group: @group
end
