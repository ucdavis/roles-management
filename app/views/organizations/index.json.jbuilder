json.cache! ['organizations_index', @cache_key] do
  json.array!(@organizations) do |organization|
    json.extract! organization, :id, :name, :dept_code, :org_id, :parent_org_id
  end
end
