source 'https://rubygems.org'

gem 'rails', '3.2.14'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   ' ~> 3.2.3'
  gem 'coffee-rails', ' ~> 3.2.1'
  gem 'uglifier',     ' >= 1.0.3'
end

group :production do
  gem 'SyslogLogger'
end

group :development do
  gem 'letter_opener'
  gem 'ruby-prof'
  gem 'debugger'
end

gem 'sqlite3', :groups => [:development, :test]
gem 'active_record_query_trace', :groups => [:development]

# Deploy with Capistrano
gem 'capistrano'

gem 'unicorn'

gem 'ruby-ldap'
gem 'rubycas-client', :git => 'https://github.com/rubycas/rubycas-client.git'
gem 'dynamic_form'

gem 'pg'

gem 'jquery-rails'
gem 'ejs'

gem 'declarative_authorization', :git => 'git://github.com/stffn/declarative_authorization.git' #, "~> 0.5.7"

# For MS Active Directory support
gem 'active_directory', :git => 'git://github.com/richardun/active_directory.git'

gem "js-routes", :git => 'git://github.com/railsware/js-routes.git'
gem "ruby_parser"

gem "rabl"

gem 'exception_notification'

# Temporary version of net-ssh to workaround broken 2.5.1
gem 'net-ssh', :git => 'git://github.com/nessche/net-ssh.git'

gem 'jbuilder'

# For scheduled tasks
gem 'whenever'

# For background processing
gem 'delayed_job_active_record'
gem 'daemons'

group :development, :test do
  gem 'jasminerice', :git => 'git://github.com/bradphelan/jasminerice.git'
  gem 'guard-jasmine'
end
