object @role
cache ['roles_show', @role]

node :member_count do
  @role.members.length
end

child @role.role_assignments.select{ |a| a.entity.status == true } => :assignments do
  attributes :id, :entity_id
  glue(:entity) {
    attributes :type, :name
  }
  node :calculated do |a|
    a.parent_id != nil
  end
end
