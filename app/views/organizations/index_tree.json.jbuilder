json.cache! ['organizations_index_tree', @cache_key] do
  json.array!(@top_level_organizations) do |top_level_organization|
    json.partial! 'organizations/index_tree_child', organization: top_level_organization
  end
end
