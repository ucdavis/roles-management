json.array!(@applications) do |application|
  json.extract! application, :id, :name

  json.operatorships application.operatorships.select{ |o| o.entity.active == true } do |operatorship|
    json.extract! entity, :id, :name, :type
  end

  json.owners application.owners.select{ |o| o.active == true } do |owner|
    json.extract! entity, :id, :name, :type
  end

  json.roles application.roles do |role|
    json.extract! role, :id, :name
  end
end
