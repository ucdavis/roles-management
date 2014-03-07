#json.cache! ['v1', @cache_key] do
  json.array!(@entities) do |entity|
    json.extract! entity, :id, :name, :type, :first, :loginid
  end
  #end
