require 'api_constraints'

DSSRM::Application.routes.draw do
  mount JasmineRails::Engine => '/specs' if defined?(JasmineRails)

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: true) do
      get '/validate' => 'base#validate'

      post 'people/import/:loginid' => 'people#import'

      resources :people
      resources :groups do
        resources :group_memberships, path: :memberships, only: [:create, :destroy]
      end
      resources :entities
      resources :applications
      resources :roles
    end
  end

  get '/welcome' => 'site#welcome', format: false, :defaults => { format: 'html' }
  get '/help' => 'site#help', format: false, :defaults => { format: 'html' }
  get '/logout' => 'site#logout'
  get '/access_denied' => 'site#access_denied'
  get '/status' => 'site#status'

  # Note: 'search' queries external databases. For an internal search, use index action with GET parameter 'q=...'
  get 'people/search' => 'people#search', :as => :people_search
  post 'people/import/:loginid' => 'people#import', :as => :person_import

  get 'entities/:id/activity' => 'entities#activity'
  get 'applications/:id/activity' => 'applications#activity'

  resources :applications
  resources :entities
  resources :people
  resources :groups
  resources :group_rules
  resources :roles
  resources :role_assignments
  resources :majors
  resources :titles
  resources :business_office_units
  resources :departments
  get 'departments/code/:code' => 'departments#show_by_code'
  get 'titles/code/:code' => 'titles#show_by_code'

  namespace 'admin' do
    get 'dialogs/impersonate'
    get 'dialogs/ip_whitelist'
    get 'ops/impersonate/:loginid', controller: 'ops', action: 'impersonate'
    get 'ops/unimpersonate'

    resources :api_whitelisted_ip_users
    resources :api_key_users
    resources :queued_jobs
    resources :tracked_items
  end

  root to: redirect('/welcome')

  # Leave this route at the end to capture 404s
  match '*path' => 'errors#error_404', via: :all
  # The above rule doesn't match the root, so add it
  match '/' => 'errors#error_404', via: :all
end
