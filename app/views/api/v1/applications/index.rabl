collection @applications
cache ['applications_index', @applications]

attributes :id, :name

child :operatorships => :operators do |operatorship|
  glue(:entity) { attributes :id, :name }
end

child :owners => :owners do |owner|
  attributes :id, :name
end

child :roles do |role|
  attributes :id, :token, :ad_path
end
