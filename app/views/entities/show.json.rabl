object @entity

attribute :uid => :id
attributes :created_at, :name

child @entity.members => :members do
  attributes :id, :loginid, :name
end

child @entity.owners => :owners do
  attributes :uid, :loginid, :name
end

child @entity.operators => :operators do
  attributes :uid, :loginid, :name
end
