DSSRM::Application.routes.draw do
  get "site/logout"
  get "site/access_denied"
  get "site/about"

  resources :applications
  resources :entities
  resources :roles

  post "/roles/assign", :controller => "role_assignments", :action => "create"
  delete "/roles/unassign", :controller => "role_assignments", :action => "destroy"

  namespace "admin" do
    get "dialogs/impersonate"
    get "dialogs/ip_whitelist"
    get "ops/impersonate/:loginid", :controller => "ops", :action => "impersonate"
    get "ops/unimpersonate"
    get "ad_path_check", :controller => "ops", :action => "ad_path_check"

    resources :api_whitelisted_ips
  end

  namespace "api" do
    resources :people

    resources :groups
    resources :ous

    resources :applications

    get "search", :controller => "custom"
    post "resolve", :controller => "custom"

    # Used on the site/index details modal group rule constructor, possibly elsewhere
    get "loginid", :controller => "custom"
    get "major", :controller => "custom"
    get "affiliation", :controller => "custom"
    get "ou", :controller => "custom"
  end

  root :to => 'applications#index'
end
