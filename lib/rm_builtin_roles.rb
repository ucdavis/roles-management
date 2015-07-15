# Provides convenient methods for accessing the built-in roles and their related data
module RmBuiltinRoles
  # Returns all roles internal to this application
  def rm_roles
    @rm_roles ||= Application.includes(:roles).find_by_name("DSS Roles Management").roles
  end

  # Returns all role IDs internal to this application
  def rm_roles_ids
    @rm_roles_ids ||= rm_roles.map{ |r| r.id }
  end

  # Returns the ID of the internal admin role
  def rm_admin_role_id
    @rm_admin_role_id ||= rm_roles.find(:first, :conditions => [ "lower(token) = 'admin'" ]).id
  end

  # Returns the ID of the internal access role
  def rm_access_role_id
    @rm_access_role_id ||= rm_roles.find(:first, :conditions => [ "lower(token) = 'access'" ]).id
  end
  
  # Returns the ID of the internal operate role
  def rm_operate_role_id
    @rm_operate_role_id ||= rm_roles.find(:first, :conditions => [ "lower(token) = 'operate'" ]).id
  end

  # Returns all entities which are listed as administrators of RM
  def rm_admin_entities
    Role.find_by_id(rm_admin_role_id).entities
  end
end
