class AffiliationPolicy < BasePolicy
  def index?
    user.has_access?
  end
end
