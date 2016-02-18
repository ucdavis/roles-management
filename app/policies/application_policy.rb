class ApplicationPolicy < BasePolicy
  def index?
    user.has_access?
  end
  
  def show?
    # A user can view an application ...
    
    # if they are an admin
    return true if user.is_admin?
    
    # if they own it
    return true if record.owners.include?(user)
    
    # if they operate it
    return true if record.operators.include?(user)
    
    false
  end
  
  def update?
    # A user can update an application ...
    
    # if they are an admin
    return true if user.is_admin?
    
    # if they own it
    return true if record.owners.include?(user)
    
    # operators cannot update an application
    
    false
  end
end
