class PersonPolicy
  attr_reader :user, :person

  def initialize(user, person)
    @user = user
    @person = person
  end

  def update?
    return true if user.is_admin?
    false
  end
  
  def show?
    return true if user.is_admin?
    false
  end
  
  def search?
    return true if user.is_admin?
    false
  end
end