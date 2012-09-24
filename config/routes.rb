DSSRM::Application.routes.draw do
  resources :classifications

  get "site/index"
  get "site/administrate"
  get "site/logout"
  get "site/access_denied"
  get "site/about"

  namespace "admin" do
    get "dialogs/impersonate"
    get "dialogs/ip_whitelist"
    get "ops/impersonate/:loginid", :controller => "ops", :action => "impersonate"
    get "ops/unimpersonate"
    get "ad_path_check", :controller => "ops", :action => "ad_path_check"

    resources :api_whitelisted_ips
  end

  resources :applications do
    resources :applications
  end

  # For AJAX on the CAO interface (checking and unchecking permission boxes)
  post "/templates/assign", :controller => "template_assignments", :action => "create"
  delete "/templates/unassign", :controller => "template_assignments", :action => "destroy"

  # For AJAX on the CAO interface (checking and unchecking permission boxes)
  post "/roles/assign", :controller => "role_assignments", :action => "create"
  delete "/roles/unassign", :controller => "role_assignments", :action => "destroy"

  resources :groups
  resources :ous
  resources :templates
  resources :roles

  resources :people do
    collection do
      match "new/:loginid", :action => "new"
    end
  end

  root :to => 'applications#index'

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
    post "resolve", :controller => "custom"
    get "org_chart", :controller => "custom"

    # Used on the site/index details modal group rule constructor, possibly elsewhere
    get "loginid", :controller => "custom"
    get "major", :controller => "custom"
    get "affiliation", :controller => "custom"
    get "ou", :controller => "custom"
  end
end
