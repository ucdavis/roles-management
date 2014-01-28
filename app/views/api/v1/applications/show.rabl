object @application
cache ['api_v1_applications_show', @application]

attributes :description, :id, :name, :url
node :icon do |a|
  a.icon.url(:normal)
end

child @application.operatorships.select{ |o| o.entity.active == true } => :operators do |operatorship|
  glue(:entity) { attributes :id, :name }
end

child @application.owners.select{ |o| o.active == true } => :owners do |owner|
  attributes :id, :name
end

child :roles do
  attributes :ad_path, :id, :token
end
