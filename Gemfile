source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem 'rails', '~> 5.1'

# Use Puma as the app server
gem 'puma', '~> 3.7'

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

group :production do
  gem 'dalli'
  # For New Relic monitoring integration
  gem 'newrelic_rpm'
end

group :development do
  gem 'capistrano', '= 3.7.2', require: false
  gem 'capistrano-bundler', '~> 1.1', require: false
  gem 'capistrano-rails',   '~> 1.1', require: false
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
end

group :development, :test do
  gem 'byebug', platform: :mri
  gem 'capybara'      # for JS integration testing
  gem 'jasmine-rails' # for JS unit testing
  gem 'poltergeist'   # for PhantomJS-based testing with capybara
  gem 'sqlite3'
  gem 'test-unit', '~> 3.2'
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
gem 'delayed_job_active_record'

# Sync script dependencies
gem 'roles-management-api', '>= 0.1.2', git: 'https://github.com/dssit/roles-management-api.git'

# For Slack notifications
gem 'json'
gem 'slack-notifier'

gem 'yaml_db'

gem 'rack-timeout'

# Force old ffi version. 1.9.21 appears to have a build issue
gem 'ffi', '1.9.18'
