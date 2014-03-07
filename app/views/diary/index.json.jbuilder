json.cache! ['diary_index', @cache_key] do
  json.array!(@entries) do |entry|
    json.uid entry.diary_uid_id
    json.date entry.created_at
    json.name entry.context.display_name
  end
end
