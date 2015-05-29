json.cache! ['api_v1_entity_show', @cache_key] do
  json.extract! @entity, :id, :name, :type, :email

  if @entity.type == 'Person'
    json.extract! @entity, :loginid
  elsif @entity.type == 'Group'
    json.members @entity.members.select{ |m| m.active == true } do |member|
      json.extract! member, :id, :type
    end
  end
end
