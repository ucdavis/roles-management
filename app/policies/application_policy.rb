class ApplicationPolicy < BasePolicy
  def index?
    user.has_access?
  end
end
