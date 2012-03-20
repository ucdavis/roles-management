DSSRM::Application.routes.draw do
  resources :classifications

  get "site/index"
  get "site/administrate"
  get "site/logout"
  get "site/access_denied"
  
  namespace "admin" do
    get "dialogs/impersonate"
    get "ops/impersonate/:loginid", :controller => "ops", :action => "impersonate"
    get "ops/unimpersonate"
  end

  resources :applications do
    resources :applications
  end

  resources :groups
  resources :ous
  resources :templates

  resources :people do
    collection do
      match "new/:loginid", :action => "new"
    end
  end
  
  root :to => redirect("/applications")

  namespace "api" do
    resources :people do
      resources :applications
      get "exists"
    end
    
    resources :groups
    resources :ous
    resources :classifications
    resources :titles
    
    resources :applications do
      resources :roles
    end
    
    get "search", :controller => "custom"
    get "resolve", :controller => "custom"
    get "org_chart", :controller => "custom"
    
    # Used on the site/index details modal group rule constructor, possibly elsewhere
    get "loginid", :controller => "custom"
    get "major", :controller => "custom"
    get "affiliation", :controller => "custom"
    get "ou", :controller => "custom"
  end
  
  # For AJAX on the CAO interface (checking and unchecking permission boxes)
  post "/roles/assign", :controller => "role_assignments", :action => "create"
  delete "/roles/unassign", :controller => "role_assignments", :action => "destroy"
end
