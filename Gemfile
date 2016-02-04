source 'https://rubygems.org'

gem 'rails', '~> 4.2.5'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.1.0'

# Use jquery as the JavaScript library
#gem 'jquery-rails'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

group :production do
  gem 'pg'
  gem 'dalli'
end

group :development do
  gem 'letter_opener'
end

gem 'spring', group: :development
gem 'web-console', '~> 2.0', group: :development

group :development, :test do
  gem 'jasmine-rails' # for JS unit testing
  gem 'capybara'      # for JS integration testing
  gem 'poltergeist'   # for PhantomJS-based testing with capybara
  gem 'sqlite3'
  gem 'byebug'        # for Ruby 2.x debugging
  gem 'test-unit', '~> 3.0'
end

gem 'exception_notification'

gem 'capistrano', '< 3.0.0'

gem 'rubycas-client', :git => 'https://github.com/rubycas/rubycas-client.git'

gem 'ejs'

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
