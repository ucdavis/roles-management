json.extract! @group, :id, :name, :type

json.group_id @group.id

json.owners @group.owners.select{ |o| o.active == true } do |owner|
  json.extract! owner, :id, :loginid, :name
end
