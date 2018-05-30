class DepartmentPolicy < BasePolicy
  def index?
    user.has_access?
  end

  def show?
    user.has_access?
  end

  def show_by_code?
    user.has_access?
  end
end
