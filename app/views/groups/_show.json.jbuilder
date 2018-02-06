json.extract! group, :id, :name, :type, :description

json.owners(group.owners.select { |o| o.active == true }) do |owner|
  json.extract! owner, :id, :loginid, :name
end

json.operators(group.operators.select { |o| o.active == true }) do |operator|
  json.extract! operator, :id, :loginid, :name
end

json.memberships(group.memberships.includes(:entity)) do |membership|
  json.extract! membership, :id, :entity_id
  json.loginid membership.entity.loginid
  json.name membership.entity.name
  json.active membership.entity.active
end

json.rules group.rules do |rule|
  json.extract! rule, :id, :column, :condition, :value
end

json.rule_members group.rule_members do |rule_member|
  json.loginid rule_member.loginid
  json.name rule_member.name
  json.person_id rule_member.id
  json.active rule_member.active
end

json.role_assignments group.role_assignments do |role_assignment|
  json.id role_assignment.id
  json.application_id role_assignment.role.application_id
  json.application_name role_assignment.role.application.name
  json.name role_assignment.role.name
  json.entity_id role_assignment.entity_id
  json.role_id role_assignment.role.id
  json.token role_assignment.role.token
end
