json.cache! ['entity_activity', @cache_key] do
  json.activities @activity.each do |act|
    json.performed_at act.performed_at
    json.message act.message
  end
end
