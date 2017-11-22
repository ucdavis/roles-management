json.cache! ['departments_index', @cache_key] do
  json.array!(@departments) do |department|
    json.extract! department, :id, :officialName, :displayName
  end
end
