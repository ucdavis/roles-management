json.extract! organization, :id, :name, :dept_code

json.org_ids organization.org_ids.map{ |org_id| org_id.org_id }

json.child_organizations organization.child_organizations do |child_organization|
  json.partial! 'organizations/index_tree_child', organization: child_organization
end
