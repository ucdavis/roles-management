source 'https://rubygems.org'

gem 'rails', '~> 3.2.22'

group :assets do
  gem 'sass-rails',   ' ~> 3.2.3'
  gem 'coffee-rails', ' ~> 3.2.1'
  gem 'uglifier',     ' >= 1.0.3'
end

group :production do
  gem 'pg'
  gem 'dalli'
end

group :development do
  gem 'letter_opener'
end

group :development, :test do
  gem 'jasmine-rails' # for JS unit testing
  gem 'capybara'      # for JS integration testing
  gem 'poltergeist'   # for PhantomJS-based testing with capybara
  gem 'sqlite3'
  gem 'byebug'        # for Ruby 2.x debugging
end

gem 'exception_notification'

gem 'strong_parameters'

gem 'capistrano', '< 3.0.0'

gem 'ruby-ldap', :require => false

gem 'rubycas-client', :git => 'https://github.com/rubycas/rubycas-client.git'

gem 'ejs'

# Possibly phasing this library out due to bugs / weird issues ...
gem 'declarative_authorization', :git => 'git@github.com:stffn/declarative_authorization.git'

# For MS Active Directory support
#gem 'net-ldap', :git => 'https://github.com/ruby-ldap/ruby-net-ldap.git', :require => false
gem 'net-ldap', :require => false

gem 'js-routes', :git => 'https://github.com/railsware/js-routes.git'

# For JSON templates
gem 'jbuilder'

# For scheduled tasks
gem 'whenever', :require => false

# For background processing
gem 'delayed_job_active_record'
gem 'daemons'

# For memory usage checks
gem 'os', :require => false

# Sync script dependencies
gem 'sysaid', :git => 'https://github.com/dssit/ruby-sysaid.git'
gem 'roles-management-api', :git => 'https://github.com/dssit/roles-management-api.git'
