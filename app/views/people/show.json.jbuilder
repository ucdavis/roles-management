json.cache! ['people_show', @cache_key] do
  json.partial! 'people/show', person: @person
end
