json.cache! ['app', @cache_key] do
  json.array!(@groups) do |group|
    json.extract! group, :id, :name, :description

    # Included for compatibility reasons. Originally gave value of group.ou_id
    # but organization relationships is now 'many' and uses group.organizations,
    # which would require changing this field to an array.
    # Until this functionality is requested, we'll simply not include organization
    # information in the group-specific JSON
    json.ou_name nil

    json.members group.members.select{ |m| m.active == true } do |member|
      json.extract! member, :id, :name, :type
    end
  end
end
