source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

#ruby '2.4.1'
ruby '>= 2.3'

gem 'rails', '~> 5.2'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.2'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# gem 'mysql2', group: [:production, :development]
gem 'pg', '0.20.0', group: [:production, :development]

# bundle exec rake doc:rails generates the API under doc/api.
# gem 'sdoc', '~> 0.4.2', group: :doc

# Reduces boot times through caching; required in config/boot.rb
#gem 'bootsnap', '>= 1.1.0', require: false

gem 'delayed_job', '>= 4.1.4', git: 'https://github.com/dssit/delayed_job.git', branch: 'allow-rails-5-2'

group :production do
  gem 'dalli'
  # For New Relic monitoring integration
  gem 'newrelic_rpm'
end

group :development do
  gem 'capistrano', '~> 3.10', require: false
  gem 'capistrano-rails',   '~> 1.3', require: false
  gem 'capistrano-passenger', require: false
  # We use our fork of capistrano3-delayed-job due to a bug in 'daemons' where delayed_job
  # will not stop correctly if not passed the number of workers in the 'stop' command
  gem 'capistrano3-delayed-job', git: 'https://github.com/cthielen/capistrano3-delayed-job.git'

  gem 'letter_opener'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
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
gem 'rubycas-client', git: 'https://github.com/rubycas/rubycas-client.git'

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

# Sync script dependencies
gem 'roles-management-api', '>= 0.1.2', git: 'https://github.com/dssit/roles-management-api.git'

# For Slack notifications
# gem 'json'
# gem 'slack-notifier'

gem 'rack-timeout'
