class TitlePolicy < BasePolicy
  def index?
    # A user can index titles ...

    # always. It's not considered sensitive information.
    return true
  end

  def show_by_code?
    user.has_access?
  end
end
