#json.cache! ['diary_show', @cache_key] do
  json.name @uid.display_name

  json.entries @uid.entries.order('created_at DESC') do |entry|
    json.extract! entry, :created_at, :message
  end
  #end
