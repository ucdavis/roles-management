object @entity
cache ['entity_show', @entity]

attributes :name, :type

child(:members => :members) { |member|
  attributes :id, :type
} if @entity.type == 'Group'
