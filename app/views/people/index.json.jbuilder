json.cache! ['people_index', @cache_key] do
  json.array!(@people) do |person|
    json.extract! person, :id, :name, :loginid, :email
  end
end
