DSSRM::Application.routes.draw do
  get "/welcome" => 'site#welcome', :format => false, :defaults => { :format => 'html' }
  get "/logout" => 'site#logout'
  get "/access_denied" => 'site#access_denied'
  get "/about" => 'site#about'
  get "/status" => "site#status"
  
  # Note: 'search' queries external databases. For an internal search, use index action with GET parameter 'q=...'
  get "people/search/:term" => "people#search", :as => :people_search
  post "people/import/:loginid" => "people#import", :as => :person_import

  resources :applications
  resources :entities
  resources :people
  resources :groups
  resources :ous
  resources :roles do
    get "sync" # HTTP GET as we queue this request - we cannot return data immediately
  end
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
    
    resources :api_whitelisted_ip_users
    resources :api_key_users
  end

  root :to => redirect("/welcome")
end
