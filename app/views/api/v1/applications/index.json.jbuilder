json.cache! ['api_v1_applications_index', @cache_key] do
  json.array!(@applications) do |application|
    json.extract! application, :id, :name

    json.operators application.operators.select{ |o| o.active == true } do |operator|
      json.extract! operator, :id, :name
    end

    json.owners application.owners.select{ |o| o.active == true } do |owner|
      json.extract! owner, :id, :name
    end

    json.roles application.roles do |role|
      json.extract! role, :id, :token, :ad_path
    end
  end
end
