class RolePolicy < BasePolicy
  include RmBuiltinRoles

  def show?
    # A user can show a role ...

    # if they own the role's application
    return true if record.application.owners.include?(user)

    # if they operate the role's application
    return true if record.application.operators.include?(user)

    return true if user.is_a? ApiWhitelistedIpUser

    return true if user.is_operator?

    super
  end

  def update?
    # A user can update a role ...

    # (they cannot if the role is the internal admin role and they are not admin)
    return false if (record.id == rm_admin_role_id) && (user.is_admin? == false)

    # if they own the role's application
    return true if record.application.owners.include?(user)

    # if they operate the role's application
    return true if record.application.operators.include?(user)

    return true if user.is_a? ApiWhitelistedIpUser

    return true if user.is_operator?

    super
  end
end
