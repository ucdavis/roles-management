# Contains helper methods useful across the entire application
module ApplicationHelper
  include Authentication

  def _has_role?(role)
    if impersonating?
      # We assume anybody impersonating is an admin and has every role anyway ...
      yield if block_given?
    else
      yield if has_role?(role)
    end
  end

  def _impersonating?
    impersonating?
  end
end
