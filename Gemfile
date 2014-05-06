source 'https://rubygems.org'

gem 'rails', '3.2.18'

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

gem 'exception_notification'

group :development, :test do
  gem 'jasmine-rails' # for JS unit testing
  gem 'capybara' # for JS integration testing
  gem 'poltergeist' # for PhantomJS-based testing with capybara
  gem 'sqlite3'
end

gem "rubysl", "~> 2.0", :platform => :rbx

gem 'capistrano', '< 3.0.0'

gem 'ruby-ldap', :require => false

gem 'rubycas-client', :git => 'https://github.com/rubycas/rubycas-client.git'

gem 'ejs'

gem 'declarative_authorization', "~> 0.5.7"

# For MS Active Directory support
gem 'net-ldap', :git => 'https://github.com/ruby-ldap/ruby-net-ldap.git', :require => false
#gem 'active_directory', :git => 'https://github.com/richardun/active_directory.git', :require => false
gem 'active_directory', :git => 'https://github.com/cthielen/active_directory.git', :require => false

gem 'js-routes', :git => 'https://github.com/railsware/js-routes.git'

# For JSON templates
gem 'jbuilder'

# For scheduled tasks
gem 'whenever', :require => false

# For background processing
gem 'delayed_job_active_record'
gem 'daemons'

# For icon processing
gem 'paperclip', '~> 3.0'

# For memory usage checks
gem 'os', :require => false
