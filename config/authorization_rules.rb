authorization do
  role :admin do
    has_permission_on [:applications, :groups, :people, :ous, :roles, :classifications, :dialogs, :templates, :template_assignments], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :authorization_rules, :to => :read
    has_permission_on :admin_dialogs, :to => :impersonate
    has_permission_on :admin_ops, :to => [:impersonate, :unimpersonate]
  end
  role :user do
    has_permission_on [:groups], :to => [:show, :new, :create, :edit, :update, :destroy]
  end
end
