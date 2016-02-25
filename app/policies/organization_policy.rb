class OrganizationPolicy < BasePolicy
  def index?
    user.has_access?
  end

  def show?
    user.has_access?
  end
end
