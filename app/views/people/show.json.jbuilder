json.cache! ['people_show', @cache_key] do
  json.extract! @person, :id, :name, :loginid, :email
end
