# Contains helper methods useful across the entire application
module ApplicationHelper
  include Authentication

  def has_role?(role)
    if current_user && (current_user.role_symbols.include?(role) || current_user.role_symbols.include?(:admin))
      return true
    end
    
    return false
  end

  def _impersonating?
    impersonating?
  end
end
