json.cache! ['department_show', @cache_key] do
  json.extract! @department, :id, :officialName, :displayName

  # Used by frontend client when searching for group rule completions
  json.name department.displayName
end
