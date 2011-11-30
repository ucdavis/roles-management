DSSRM::Application.routes.draw do
  resources :classifications

  get "site/index"
  get "site/contact"  
  get "site/logout"
  get "site/access_denied"

  resources :applications do
    resources :roles
  end

  resources :groups
  resources :ous

  resources :people do
    collection do
      match "new/:loginid", :action => "new"
    end
  end
  
  root :to => "site#index"

  namespace "api" do
    resources :people do
      resources :applications
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
  end
end
