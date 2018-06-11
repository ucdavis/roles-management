json.cache! ['admin_api_key_users_index', @cache_key] do
  json.array!(@api_keys) do |key|
    json.extract! key, :id, :name, :secret, :logged_in_at
  end
end
