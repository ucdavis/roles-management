class RoleAssignmentPolicy < BasePolicy
  include RmBuiltinRoles

  def create?
    # A user can create a role assignment ...

    # if they own the role's application
    return true if record.role.application.owners.include?(user)

    # if they operate the role's application
    return true if record.role.application.operators.include?(user)

    return true if user.is_a? ApiWhitelistedIpUser

    return true if user.is_operator?

    super
  end

  def destroy?
    # A user can destroy a role assignment ...

    # if they own the role's application
    return true if record.role.application.owners.include?(user)

    # if they operate the role's application
    return true if record.role.application.operators.include?(user)

    return true if user.is_a? ApiWhitelistedIpUser

    return true if user.is_operator?

    super
  end
end
