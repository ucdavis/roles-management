json.cache! ['app', @cache_key] do
  json.array!(@groups) do |group|
    json.extract! group, :id, :name, :description, :ou_id
    
    json.ou_name group.ou_id ? group.ou.name : nil
    
    json.members group.members.select{ |m| m.active == true } do |member|
      json.extract! member, :id, :name, :type
    end
  end
end
