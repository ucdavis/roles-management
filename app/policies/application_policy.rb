class ApplicationPolicy < BasePolicy
  def index?
    user.has_access?
  end
  
  def show?
    return true if user.is_admin?
    
  end
end
