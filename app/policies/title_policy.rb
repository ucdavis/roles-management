class TitlePolicy < BasePolicy
  def index?
    # A user can index titles ...

    # always. It's not considered sensitive information.
    return true
  end
end
