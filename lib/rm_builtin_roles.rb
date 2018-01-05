# Provides convenient methods for accessing the built-in roles and their related data
module RmBuiltinRoles
  # Returns all role IDs internal to this application
  def rm_roles_ids
    @rm_roles_ids ||= Application.find_by_name('DSS Roles Management').roles.select(:id).map(&:id)
  end

  # Returns the ID of the internal admin role
  def rm_admin_role_id
    @rm_admin_role_id ||= Role.where(token: 'admin', application_id: Application.find_by(name: 'DSS Roles Management').id).select(:id).map(&:id)
  end

  # Returns the ID of the internal access role
  def rm_access_role_id
    @rm_access_role_id ||= Role.where(token: 'access', application_id: Application.find_by(name: 'DSS Roles Management').id).select(:id).map(&:id)
  end

  # Returns the ID of the internal operate role
  def rm_operate_role_id
    @rm_operate_role_id ||= Role.where(token: 'operate', application_id: Application.find_by(name: 'DSS Roles Management').id).select(:id).map(&:id)
  end
end
