require File.expand_path('../boot', __FILE__)

require 'rails/all'

if defined?(Bundler)
  # If you precompile assets before deploying to production, use this line
  # Bundler.require *Rails.groups(:assets => %w(development test))
  # If you want your assets lazily compiled in production, use this line
  # Bundler.require(:default, :assets, Rails.env)
  
  Bundler.setup *Rails.groups(:assets => %w(development test))
  
  require 'rails'

  # # Gems used only for assets and not required
  # # in production environments by default.
  # group :assets do
  #   gem 'sass-rails',   ' ~> 3.2.3'
  #   gem 'coffee-rails', ' ~> 3.2.1'
  #   gem 'uglifier',     ' >= 1.0.3'
  # end
  # 
  # group :development do
  #   gem 'letter_opener'
  #   gem 'ruby-prof'
  #   gem 'debugger'
  # end
  # 
  # gem 'sqlite3', :groups => [:development, :test]
  # gem 'active_record_query_trace', :groups => [:development]
  # 
  # # Deploy with Capistrano
  # #gem 'capistrano'
  # 
  # #gem 'unicorn'
  # 
  # gem 'ruby-ldap'
  require 'rubycas-client'
  # gem 'rubycas-client', :git => 'https://github.com/rubycas/rubycas-client.git'
  # gem 'dynamic_form'
  # 
  # #gem 'pg'
  # 
  # gem 'jquery-rails'
  # gem 'ejs'
  # 
  require 'declarative_authorization'
  
  require 'paperclip'
  # gem 'declarative_authorization', :git => 'git://github.com/stffn/declarative_authorization.git' #, "~> 0.5.7"
  # 
  # # For MS Active Directory support
  # gem 'active_directory', :git => 'git://github.com/richardun/active_directory.git'
  # 
  # #gem 'js-routes', :git => 'git://github.com/railsware/js-routes.git'
  # gem 'ruby_parser'
  # 
  require 'rabl'
  # gem 'rabl'
  # gem 'oj'
  # 
  require 'exception_notification'
  # 
  # # Temporary version of net-ssh to workaround broken 2.5.1
  # gem 'net-ssh', :git => 'git://github.com/nessche/net-ssh.git'
  # 
  # gem 'jbuilder'
  # 
  # # For scheduled tasks
  # #gem 'whenever'
  # 
  # # For background processing
  # gem 'delayed_job_active_record'
  # gem 'daemons'
  # 
  # # For icon processing
  # gem 'paperclip', '~> 3.0'

  # For memory usage checks
  #gem 'os'
end

module DSSRM
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)
    config.autoload_paths += %W(#{config.root}/lib)
    config.autoload_paths += Dir["#{config.root}/lib/**/"]

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    config.action_view.javascript_expansions[:defaults] = ['jquery']

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]

    # Enable the asset pipeline
    config.assets.enabled = true

    # Version of your assets, change this if you want to expire all your assets
    config.assets.version = '1.24'

    config.assets.paths << Rails.root.join("app", "assets", "javascripts", "controllers")
    config.assets.paths << Rails.root.join("app", "assets", "templates")
  end
end
