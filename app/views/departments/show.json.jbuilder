json.cache! ['department_show', @cache_key] do
  json.extract! @department, :id, :officialName, :displayName
end
