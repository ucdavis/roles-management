class OpsPolicy < BasePolicy
  def impersonate?
    return true if user.is_admin?
    false
  end

  def unimpersonate?
    return true if user.is_admin?
    false
  end
end
