class BusinessOfficeUnitPolicy < BasePolicy
  def index?
    # A user can index business office units ...

    # always. It's not considered sensitive information.
    return true
  end
end
