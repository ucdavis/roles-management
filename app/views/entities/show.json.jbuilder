json.cache! ['entity_show', @cache_key] do
  if @entity.type == 'Person'
    json.partial! 'people/show', person: @entity
  elsif @entity.type == 'Group'
    json.partial! 'groups/show', group: @entity
  end
end
