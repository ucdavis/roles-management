object @person
cache ['people_show', @person]

attributes :address, :byline, :email, :first, :id, :last, :loginid, :name, :phone, :type

glue(:title) { attribute :name => :title }
node(:title, :unless => lambda { |p| p.title }) {} # ensure an empty title shows up

child :group_memberships do |membership|
  attributes :group_id, :id
  glue(:group) {
    attribute :name
  }
end

child :group_ownerships do |ownership|
  attributes :id, :group_id
  
  glue(:group) { attribute :name }
end

child :group_operatorships do
  attributes :id, :group_id
  
  glue(:group) { attribute :name }
end

child :role_assignments do
  attributes :id, :role_id
  
  glue(:role) {
    attributes :name, :token, :application_id
    glue(:application) { attribute :name => :application_name }
  }
end
