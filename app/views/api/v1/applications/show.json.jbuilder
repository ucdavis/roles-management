json.cache! ['api_v1_applications_show', @cache_key] do
  json.extract! @application, :description, :id, :name, :url

  json.operators @application.operators.select{ |o| o.active == true } do |operator|
    json.extract! operator, :id, :name
  end

  json.owners @application.owners.select{ |o| o.active == true } do |owner|
    json.extract! owner, :id, :name
  end

  json.roles @application.roles do |role|
    json.extract! role, :ad_path, :id, :token
  end
end
