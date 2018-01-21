json.cache! ['departments_index', @cache_key] do
  json.array!(@departments) do |department|
    json.extract! department, :id, :officialName, :displayName

    # Used by frontend client when searching for group rule completions
    json.name department.displayName
  end
end
