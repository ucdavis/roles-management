json.cache! ['api_v1_people_show', @cache_key] do
  json.extract! @person, :address, :byline, :email, :first, :id, :last, :loginid, :name, :phone, :type

  json.group_memberships @person.group_memberships do |membership|
    json.extract! membership, :group_id, :id
    json.name membership.group.name
    json.ou false # this field has been removed from the database for groups but remains here as 'false' for compatibility in API v1
  end

  json.group_ownerships @person.group_memberships do |ownership|
    json.extract! ownership, :id, :group_id
    json.name ownership.group.name
  end

  json.group_operatorships @person.group_operatorships do |operatorship|
    json.extract! operatorship, :id, :group_id
    json.name operatorship.group.name
  end

  json.role_assignments @person.role_assignments do |assignment|
    json.extract! assignment, :id, :role_id

    json.name assignment.role.name
    json.token assignment.role.token
    json.application_id assignment.role.application_id
    json.application_name assignment.role.application.name
  end
end
