object @entity
cache ['entity_show', @entity]

attributes :name, :type, :email

child(:members => :members) { |member|
  attributes :id, :type
} if @entity.type == 'Group'
