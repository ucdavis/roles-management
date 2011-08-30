DSSRM::Application.routes.draw do
  get "site/index"

  get "site/contact"
  
  get "site/logout"

  resources :applications do
    resources :roles
  end

  resources :groups
  resources :ous

  resources :people do
    collection do
      get 'new_from_ldap'
      post 'new_from_ldap'
    end
  end

  root :to => "site#index"

  namespace "api" do
    resources :people do
      resources :applications
    end
    
    resources :groups
    resources :ous
    
    resources :applications do
      resources :roles
    end
    
    get "search", :controller => "custom"
    get "resolve", :controller => "custom"
  end
end
