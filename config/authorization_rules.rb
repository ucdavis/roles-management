authorization do
  role :admin do
    has_permission_on [:applications, :groups, :people, :ous, :roles], :to => [:index, :show, :new, :create, :edit, :update, :destroy]
  end
end
