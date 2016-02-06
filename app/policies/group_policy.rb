class GroupPolicy < BasePolicy
  def activity?
    return true if user.is_admin?
    false
  end
end
