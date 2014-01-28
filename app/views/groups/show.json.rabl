object @group
cache ['groups_show', @group]

attributes :id, :name, :type, :description

child @group.owners.select{ |o| o.active == true } => :owners do
  attributes :id, :loginid, :name
end

child @group.operators.select{ |o| o.active == true } => :operators do
  attributes :id, :loginid, :name
end

child @group.memberships.includes(:entity).select{ |m| m.entity.active == true } => :memberships do
  attributes :id, :entity_id, :calculated
  glue(:entity) {
    attributes :loginid, :name
  }
end

child @group.rules => :rules do
  attributes :id, :column, :condition, :value
end
