collection @applications
cache ['api_v1_applications_index', @applications]

@applications.each do |application|
  attributes :id, :name

  child application.operatorships.select{ |o| o.entity.status == true } => :operators do |operatorship|
    glue(:entity) { attributes :id, :name }
  end

  child application.owners.select{ |o| o.status == true } => :owners do |owner|
    attributes :id, :name
  end

  child :roles do |role|
    attributes :id, :token, :ad_path
  end
end
