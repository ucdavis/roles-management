authorization do
  role :admin do
    # For creating/deleting applications
    has_permission_on :applications, :to => [:create, :delete]
    has_permission_on :application_owner_assignments, :to => [:create, :delete]
    has_permission_on :roles, :to => [:create, :delete]
  end
  
  role :access do
    # Allow access to the main page
    has_permission_on :applications, :to => :index
    
    # Operators can read applications
    has_permission_on :applications, :to => :read do
      if_attribute :operators => contains { user }
    end
    # Owners can read and update their own applications
    has_permission_on :applications, :to => [:read, :update] do
      if_attribute :owners => contains { user }
    end
    # NOTE: 'access' role cannot create or destroy applications
    
    # Allow creating/updating/reading of roles which belong to an application they own
    has_permission_on :roles, :to => [:read, :update, :create, :delete] do
      if_attribute :application => { :owners => contains { user } }
    end
    
    # Owning/operating applications requires reading entities
    has_permission_on :entities, :to => :show do
      if_permitted_to :update, :applications
    end
    # Create/delete role_assignments for applications they own
    has_permission_on :role_assignments, :to => [:create, :delete] do
      if_attribute :role => { :application => { :owners => contains { user } } }
    end
    # Create/delete role_assignments for applications they operate
    has_permission_on :role_assignments, :to => [:create, :delete] do
      if_attribute :role => { :application => { :operators => contains { user } } }
    end
    
    has_permission_on :people, :to => :read
    # You can only update your own details
    has_permission_on :people, :to => :update do
      if_attribute :id => is { user.id }
    end
  end
end

privileges do
  privilege :manage, :includes => [:create, :read, :update, :delete]
  privilege :read, :includes => [:index, :show]
  privilege :create, :includes => :new
  privilege :update, :includes => :edit
  privilege :delete, :includes => :destroy
end
