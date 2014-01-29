collection @applications
#cache ['applications_index', @applications]

@applications.each do |application|
  attributes :id, :name

  child application.operatorships.select{ |o| o.entity.active == true } => :operators do |operatorship|
    glue(:entity) { attributes :id, :name, :type }
  end

  child application.owners.select{ |o| o.active == true } => :owners do |owner|
    attributes :id, :name, :type
  end

  child :roles do |role|
    attributes :id, :name
  end
end
