authorization do
  role :admin do
    has_permission_on [:applications, :groups, :people, :roles, :classifications, :entities], :to => [:index, :show, :new, :create, :edit, :update, :destroy, :delete]
    has_permission_on :authorization_rules, :to => :read
    has_permission_on :admin_dialogs, :to => [:impersonate, :ip_whitelist]
    has_permission_on :admin_ops, :to => [:impersonate, :unimpersonate]
    has_permission_on :role_assignments, :to => [:create, :delete]
    has_permission_on :admin_ops, :to => [:ad_path_check]
    has_permission_on :aptplication_owner_assignments, :to => [:create, :delete]
    has_permission_on :group_owner_assignments, :to => [:create, :delete, :update]
    has_permission_on :group_rules, :to => [:create, :delete, :update]
    has_permission_on :group_operator_assignments, :to => [:create, :delete]
    has_permission_on :person_favorite_assignments, :to => [:create, :update, :delete]
    has_permission_on :application_owner_assignments, :to => [:create, :update, :delete]
    has_permission_on :api_whitelisted_ips, :to => [:create, :delete]
    has_permission_on :admin_api_whitelisted_ips, :to => [:index, :create, :destroy]
  end
  role :access do
    has_permission_on :groups, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :entities, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :applications, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :delete]
    has_permission_on :people, :to => [:index, :show, :edit, :update]
    has_permission_on :role_assignments, :to => [:create, :delete]
    has_permission_on :group_owner_assignments, :to => [:create, :delete, :update]
    has_permission_on :group_rules, :to => [:create, :delete, :update]
    has_permission_on :group_operator_assignments, :to => [:create, :delete]
    has_permission_on :application_owner_assignments, :to => [:create, :delete]
    has_permission_on :roles, :to => [:create, :update, :delete]
    has_permission_on :person_favorite_assignments, :to => [:create, :update, :delete]
    has_permission_on :application_owner_assignments, :to => [:create, :update, :delete]
  end
end
