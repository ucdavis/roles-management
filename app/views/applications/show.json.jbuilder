json.cache! ['application_show', @cache_key] do
  json.extract! @application, :id, :name, :url, :description

  json.roles @application.roles do |role|
    json.id role.id
    json.description role.description
    json.token role.token
    json.name role.name
    json.ad_path role.ad_path
  end

  json.owners @application.application_ownerships do |o|
    json.name o.entity.name
    json.id o.entity.id
    json.calculated o.parent_id?
  end

  json.operatorships @application.operatorships do |o|
    json.name o.entity.name
    json.entity_id o.entity.id
    json.id o.id
    json.calculated o.parent_id?
  end
end
