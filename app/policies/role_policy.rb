class RolePolicy < BasePolicy
  def show?
    # A user can show a role ...
  
    # if they own the role's application
    return true if record.application.owners.include?(user)
    
    # if they operate the role's application
    return true if record.application.operators.include?(user)
  
    super
  end
end
