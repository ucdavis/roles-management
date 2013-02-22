authorization do
  role :admin do
    has_permission_on :authorization_rules, :to => :read
    has_permission_on :admin_dialogs, :to => [:impersonate, :ip_whitelist]
    has_permission_on :admin_ops, :to => [:impersonate, :unimpersonate]
    has_permission_on :admin_ops, :to => [:ad_path_check]
    has_permission_on :api_whitelisted_ips, :to => [:create, :delete]
    has_permission_on :admin_api_whitelisted_ips, :to => [:index, :create, :destroy]
    has_permission_on :api_key_users, :to => [:create, :delete]
    has_permission_on :admin_api_keys, :to => [:index, :create, :destroy]
  end
  role :access do
    has_permission_on :groups, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :delete]
    has_permission_on :entities, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :applications, :to => [:index, :show, :new, :create, :edit, :update, :destroy, :delete]
    has_permission_on :people, :to => [:index, :show, :edit, :update]
    has_permission_on :role_assignments, :to => [:create, :delete]
    has_permission_on :group_owner_assignments, :to => [:create, :delete, :update]
    has_permission_on :group_rules, :to => [:create, :delete, :update]
    has_permission_on :group_operator_assignments, :to => [:create, :delete]
    has_permission_on :application_owner_assignments, :to => [:create, :delete]
    has_permission_on :roles, :to => [:index, :show, :create, :update, :delete]
    has_permission_on :person_favorite_assignments, :to => [:create, :update, :delete]
    has_permission_on :application_owner_assignments, :to => [:create, :update, :delete]
    has_permission_on :application_operator_assignments, :to => [:create, :update, :delete]
    has_permission_on :ous, :to => [:index]
    has_permission_on :majors, :to => [:index]
    has_permission_on :titles, :to => [:index]
    has_permission_on :classifications, :to => [:index]
    has_permission_on :affiliations, :to => [:index]
  end
end
