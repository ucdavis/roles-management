source 'https://rubygems.org'

gem 'rails', '3.2.14'

group :assets do
  gem 'sass-rails',   ' ~> 3.2.3'
  gem 'coffee-rails', ' ~> 3.2.1'
  gem 'uglifier',     ' >= 1.0.3'
end

group :production do
  gem 'syslogger', :git => 'https://github.com/cthielen/syslogger.git'
  gem 'pg'
  gem 'unicorn'
  gem 'unicorn-worker-killer'
end

group :development do
  gem 'letter_opener'
  gem 'ruby-prof'
  gem 'debugger'
  gem 'active_record_query_trace'
end

group :development, :test do
  gem 'jasminerice', :git => 'git://github.com/bradphelan/jasminerice.git'
  gem 'guard-jasmine'
  gem 'sqlite3'
end

gem 'capistrano', '< 3.0.0'

gem 'ruby-ldap', :require => false

gem 'rubycas-client', :git => 'https://github.com/rubycas/rubycas-client.git'

gem 'ejs'

gem 'declarative_authorization', "~> 0.5.7"

# For MS Active Directory support
gem 'net-ldap', :git => 'git://github.com/ruby-ldap/ruby-net-ldap.git', :require => false
#gem 'active_directory', :git => 'git://github.com/richardun/active_directory.git', :require => false
gem 'active_directory', :git => 'git://github.com/cthielen/active_directory.git', :require => false

gem 'js-routes', :git => 'git://github.com/railsware/js-routes.git', :require => false

gem 'rabl'
gem 'oj'

gem 'exception_notification'

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
