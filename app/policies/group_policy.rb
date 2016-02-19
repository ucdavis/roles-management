class GroupPolicy < BasePolicy
  def show?
    # A user can show a group ...
    
    # if they're an admin
    return true if user.is_admin?
    
    # if they own the group
    return true if record.owners.include?(user)
    
    # if they operate the group
    return true if record.operators.include?(user)
    
    false
  end
  
  def update?
    # A user can show a group ...
    
    # if they're an admin
    return true if user.is_admin?
    
    # if they own the group
    return true if record.owners.include?(user)
    
    # operators cannot update an application
    
    super
  end
  
  def activity?
    return true if user.is_admin?
    false
  end
end
