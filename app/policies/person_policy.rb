class PersonPolicy < BasePolicy
  def update?
    return true if user.is_admin?
    false
  end
  
  def show?
    return true if user.is_admin?
    false
  end
  
  def search?
    return true if user.is_admin?
    false
  end
  
  def import?
    return true if user.is_admin?
    false
  end
  
  def activity?
    return true if user.is_admin?
    false
  end
end
