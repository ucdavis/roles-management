json.array!(@applications) do |application|
  json.extract! application, :id, :name

  json.operatorships application.operators.select{ |o| o.active == true } do |operator|
    json.extract! operator, :id, :name, :type
  end

  json.owners application.owners.select{ |o| o.active == true } do |owner|
    json.extract! owner, :id, :name, :type
  end

  json.roles application.roles do |role|
    json.extract! role, :id, :name
  end
end
