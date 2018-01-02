json.cache! ['bous_index', @cache_key] do
  json.array!(@bous) do |bou|
    json.extract! bou, :id, :dept_official_name, :org_oid

    # Used by frontend client when searching for group rule completions
    json.name bou.dept_official_name
  end
end
