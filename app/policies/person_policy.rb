class PersonPolicy < BasePolicy
  def index?
    user.has_access?
  end
  
  def show?
    user.has_access?
  end
  
  def update?
    # A user can update a person ...

    # if they have access and ...
    if user.has_access?
      # the person they're updating is themselves ...
      if user == record
        # and they're changing nothing about themselves
        # (this is used when giving yourself a favorite, probably via a .touch())
        if record.changes.length == 0
          return true
        end
      end
    end
    
    super
  end
  
  def search?
    return true if user.is_admin?
    false
  end
  
  def import?
    return true if user.is_admin?
    false
  end
  
  def activity?
    return true if user.is_admin?
    false
  end
end
