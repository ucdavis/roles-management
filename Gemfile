source 'https://rubygems.org'

gem 'rails', '~> 3.2.21'

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
  gem 'capybara' # for JS integration testing
  gem 'poltergeist' # for PhantomJS-based testing with capybara
  gem 'sqlite3'
  gem 'byebug' # for Ruby 2.x debugging
end

gem 'exception_notification'

gem 'strong_parameters'

gem 'capistrano', '< 3.0.0'

gem 'ruby-ldap', :require => false

gem 'rubycas-client', :git => 'https://github.com/rubycas/rubycas-client.git'

gem 'ejs'

# Phasing this library out due to bugs ...
gem 'declarative_authorization', "~> 0.5.7"
# Using this library instead ...
gem 'cancancan', '~> 1.8'

# For MS Active Directory support
gem 'net-ldap', :git => 'https://github.com/ruby-ldap/ruby-net-ldap.git', :require => false
#gem 'active_directory', :git => 'https://github.com/richardun/active_directory.git', :require => false
gem 'active_directory', :git => 'https://github.com/cthielen/active_directory.git', :require => false
#gem 'active_directory', :git => 'https://github.com/ajrkerr/active_directory.git', :require => false

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

gem 'sysaid'
