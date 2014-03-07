json.cache! ['api_v1_roles_show', @cache_key] do
  json.extract! @role, :application_id, :description, :name, :token

  json.members @role.members.select{ |m| m.active == true } do |member|
    json.extract! member, :id, :loginid, :name
  end
end
