object @entity
cache ['api_v1_entity_show', @entity]

attributes :name, :type, :email

child(:members => :members) { |member|
  attributes :id, :type
} if @entity.type == 'Group'
