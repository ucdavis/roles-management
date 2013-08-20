object @application
cache @application

attributes :description, :id, :name

child :operators => :operators do |operator|
  attributes :id, :name
end

child :owners => :owners do |owner|
  attributes :id, :name
end

child :roles do
  attributes :ad_path, :id, :token
end
