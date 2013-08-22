object @application
cache ['applications_show', @application]

attributes :description, :id, :name, :url
node :icon do |a|
  a.icon.url(:normal)
end

child :operators => :operators do |operator|
  attributes :id, :name
end

child :owners => :owners do |owner|
  attributes :id, :name
end

child :roles do
  attributes :ad_path, :id, :token
end
