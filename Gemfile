source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '>= 3.2'
gem 'rexml' # no longer bundled with Ruby 3.0+

gem 'rails', '~> 6.1'
gem 'concurrent-ruby', '< 1.3.5' # https://github.com/rails/rails/pull/54264

# Use Puma as the app server
gem 'puma', '~> 5.6'

# Use SCSS for stylesheets
gem 'sassc-rails', '~> 2.1'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

gem 'mysql2', group: [:production, :development]

# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.2', group: :doc

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'delayed_job'
gem 'delayed_job_active_record'

group :production do
  gem 'dalli'
  # For New Relic monitoring integration
  gem 'newrelic_rpm'
end

group :development do
  gem 'listen', '~> 3.0'
  gem 'web-console', '>= 3.3.0'
  gem 'byebug', platform: :mri
end

group :test do
  gem 'capybara', '>= 2.15', '< 4.0' # for JS integration testing
  gem 'jasmine-rails'                # for JS unit testing
  gem 'poltergeist'                  # for PhantomJS-based testing with capybara
  gem 'sqlite3'
  gem 'test-unit', '~> 3.2'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'exception_notification'

# For CAS authentication
gem 'rack-cas'

gem 'ejs'

# For authorization
gem 'pundit'

# For LDAP & Active Directory support
gem 'net-ldap', require: false

gem 'js-routes'

# For scheduled tasks
gem 'whenever', require: false

# For background processing
gem 'daemons'

gem 'rack-timeout'

# For AWS DynamoDB support, used in activity logs
gem 'aws-sdk-dynamodb', '~> 1.6'
gem 'aws-sdk-core', '~> 3.0'

gem 'mechanize', require: false

# DocuSign user management
gem 'docusign_esign', '~> 3.20'
