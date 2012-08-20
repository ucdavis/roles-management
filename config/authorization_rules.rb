authorization do
  role :admin do
    has_permission_on [:applications, :groups, :people, :ous, :roles, :classifications, :dialogs, :templates, :template_assignments], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :authorization_rules, :to => :read
    has_permission_on :admin_dialogs, :to => [:impersonate, :ip_whitelist]
    has_permission_on :admin_ops, :to => [:impersonate, :unimpersonate]
  end
  role :access do
    has_permission_on :groups, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :applications, :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :people, :to => [:index, :show, :edit, :update]
  end
end
