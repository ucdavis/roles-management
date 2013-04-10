authorization do
  role :admin do
    has_permission_on :admin_dialogs, :to => [:impersonate, :ip_whitelist]
    has_permission_on :admin_ops, :to => [:impersonate, :unimpersonate, :ad_path_check]
    has_permission_on :api_whitelisted_ip_users, :to => [:create, :delete]
    has_permission_on :admin_api_whitelisted_ips, :to => [:index, :create, :delete]
    has_permission_on :api_key_users, :to => [:create, :delete]
    has_permission_on :admin_api_keys, :to => [:index, :create, :delete]
    has_permission_on :roles, :to => [:sync]
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
