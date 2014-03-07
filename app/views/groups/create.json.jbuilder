#json.cache! ['groups_create', @cache_key] do
  json.extract! @group, :id, :name, :type
  
  json.group_id @group.id

  json.owners @group.owners.select{ |o| o.active == true } do |owner|
    json.extract! owner, :id, :loginid, :name
  end

  # json.operators @group.operators.select{ |o| o.active == true } do |operator|
  #   json.extract! operator, :id, :loginid, :name
  # end
  # 
  # json.memberships @group.memberships.includes(:entity).select{ |m| m.entity.active == true } do |membership|
  #   json.extract! membership, :id, :entity_id, :calculated
  #   json.loginid membership.entity.loginid
  #   json.name membership.entity.name
  # end
  # 
  # json.rules @group.rules do |rule|
  #   json.extract! rule, :id, :column, :condition, :value
  # end
  #end
