source 'https://rubygems.org'

gem 'rails', '~> 4.0.13'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.2'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
#gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
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

gem 'capistrano', '< 3.0.0'

gem 'rubycas-client', :git => 'https://github.com/rubycas/rubycas-client.git'

gem 'ejs'

# Possibly phasing this library out due to bugs / weird issues ...
gem 'declarative_authorization', :git => 'git@github.com:stffn/declarative_authorization.git'
# Considering using this library instead ...
gem 'cancancan', '~> 1.10'

# For LDAP & Active Directory support
gem 'net-ldap', :require => false

gem 'js-routes'

# For scheduled tasks
gem 'whenever', :require => false

# For background processing
gem 'delayed_job_active_record'
gem 'daemons'

# Sync script dependencies
gem 'sysaid', :git => 'https://github.com/dssit/ruby-sysaid.git'
gem 'roles-management-api', :git => 'https://github.com/dssit/roles-management-api.git'

# For New Relic monitoring integration
gem 'newrelic_rpm'
