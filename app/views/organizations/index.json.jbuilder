json.cache! ['organizations_index', @cache_key] do
  json.array!(@organizations) do |organization|
    json.extract! organization, :id, :name, :dept_code
    
    json.org_ids organization.org_ids.map{ |org_id| org_id.org_id }
  end
end
