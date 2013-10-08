object @role
cache ['roles_show', @role]

attributes :application_id, :description, :name, :token

child @role.members.select{ |m| m.status == true } => :members do
  attributes :id, :loginid, :name
end
