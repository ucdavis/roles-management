object @entity

attributes :id, :created_at, :name

child :members do
  attributes :id
end
