authorization do
  role :admin do
    has_permission_on [:applications, :groups, :people, :ous, :roles, :classifications, :dialogs], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
    has_permission_on :authorization_rules, :to => :read
    has_permission_on :admin_dialogs, :to => :impersonate
  end
end
