class ApplicationPolicy < BasePolicy
  def index?
    user.has_access?
  end
  
  def show?
    # A user can show an application ...
    
    # if they own it
    return true if record.owners.include?(user)
    
    # if they operate it
    return true if record.operators.include?(user)
    
    super
  end
  
  def update?
    # A user can update an application ...
    
    # if they own it
    return true if record.owners.include?(user)
    
    # operators cannot update an application
    
    super
  end
end