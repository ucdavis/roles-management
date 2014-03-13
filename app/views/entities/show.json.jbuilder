json.cache! ['entity_show', @cache_key] do
  json.extract! @entity, :id, :description, :type, :email, :name

  if @entity.type == 'Group'
    json.memberships @entity.memberships.select{ |m| m.entity.active == true } do |membership|
      json.extract! membership, :id, :calculated
      json.loginid membership.entity.loginid
      json.name membership.entity.name
      json.entity_id membership.entity.id
    end
    json.operators @entity.operators.select{ |m| m.active == true } do |operator|
      json.extract! operator, :id, :name, :loginid
    end
    json.owners @entity.owners.select{ |m| m.active == true } do |owner|
      json.extract! owner, :id, :name, :loginid
    end
    json.rules @entity.rules do |rule|
      json.extract! rule, :column, :condition, :value, :id
    end
  end
end
