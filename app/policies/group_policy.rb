class GroupPolicy < BasePolicy
  def show?
    # A user can show a group ...

    # if they're an admin
    return true if user.is_admin?

    # if they're an operator
    return true if user.is_operator?

    # if they own the group
    return true if record.owners.include?(user)

    # if they operate the group
    return true if record.operators.include?(user)

    # if they just have access (to enable cross-org group re-use)
    return true if user.has_access?

    false
  end

  def update?
    # A user can show a group ...

    # if they're an admin
    return true if user.is_admin?

    # if they own the group
    return true if record.owners.include?(user)

    # operators cannot update a group

    super
  end

  def activity?
    return true if user.is_admin?
    false
  end

  def create?
    # Users are allowed to create groups.
    return true if user.has_access?
    false
  end

  def destroy?
    # A user can destroy a group ...

    # if they're an admin
    return true if user.is_admin?

    # if they own the group
    return true if record.owners.include?(user)

    # operators cannot destroy a group

    false
  end
end
