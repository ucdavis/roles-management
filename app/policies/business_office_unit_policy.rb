class BusinessOfficeUnitPolicy < BasePolicy
  def index?
    # A user can index business office units ...

    # always. It's not considered sensitive information.
    return true
  end

  def show_by_code?
    # A user can show a business office unit by code ...

    # always. It's not considered sensitive information.
    return true
  end
end
