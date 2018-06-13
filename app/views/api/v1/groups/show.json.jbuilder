json.cache! ['api_v1_groups_show', @cache_key] do
  json.extract! @group, :id, :name

  json.rules(@group.rules) do |rule|
    json.extract! rule, :id, :column, :condition, :value
  end

  json.owners(@group.owners) do |owner|
    json.extract! owner, :id, :loginid, :name
  end

  json.group_ownerships(@group.group_ownerships) do |group_ownership|
    json.extract! group_ownership, :id, :group_id, :entity_id
  end

  json.memberships(@group.memberships.select { |m| m.entity.active == true }) do |membership|
    json.extract! membership, :id, :entity_id
  end

  json.members(@group.members.select { |m| m.active == true }) do |member|
    json.extract! member, :id, :name, :type

    if member.type == 'Person'
      json.email member.email
      json.first member.first
      json.last member.last
      json.loginid member.loginid
    end
  end
end
