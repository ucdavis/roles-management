# The 'built-in' RM roles must exist for proper functionality.

# Lazy-load the data as test scenarios will clear the database before initializers are run,
# resulting in Application.find_by_name failing unnecessarily.

def rm_roles
  @rm_roles ||= Application.includes(:roles).find_by_name("DSS Roles Management").roles
end

def rm_roles_ids
  @rm_roles_ids ||= rm_roles.map{ |r| r.id }
end
