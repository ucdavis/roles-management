json.array!(@roles) do |role|
  json.id role.id
  json.name role.name
  json.application_id role.application_id
  json.application_name role.application_name
end
