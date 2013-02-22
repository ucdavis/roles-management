DSSRM::Application.routes.draw do
  get "site/welcome"
  get "site/logout"
  get "site/access_denied"
  get "site/faq"
  get "site/contact"
  get "site/request_access"
  get "site/about"

  resources :applications
  resources :entities
  resources :people
  resources :groups
  resources :ous
  resources :roles
  resources :majors
  resources :titles
  resources :affiliations
  resources :classifications

  namespace "admin" do
    get "dialogs/impersonate"
    get "dialogs/ip_whitelist"
    get "ops/impersonate/:loginid", :controller => "ops", :action => "impersonate"
    get "ops/unimpersonate"
    get "ad_path_check", :controller => "ops", :action => "ad_path_check"

    resources :api_whitelisted_ips
    resources :api_keys
  end

  root :to => 'site#welcome'
end
