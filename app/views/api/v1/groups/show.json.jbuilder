json.cache! ['api_v1_groups_show', @cache_key] do
  json.extract! @group, :id, :name

  json.members @group.members do |member|
    json.extract! member, :id, :name, :type

    if member.type == 'Person'
      json.email member.email
    end
  end
end
