object @role
cache ['roles_show', @role]

attributes :application_id, :description, :name, :token

child :entities => :members do
  attributes :id, :loginid, :name
end