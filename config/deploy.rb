# config valid only for current version of Capistrano
lock '~> 3.10'

set :application, 'roles-management'
set :repo_url, 'https://github.com/dssit/roles-management.git'

# Temporary fix for restarting the application until Passenger v5.0.10
set :passenger_restart_with_touch, true

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/home/deployer/apps/#{fetch(:application)}"

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml', 'config/general.yml', 'config/api_keys.yml', 'config/newrelic.yml', 'sync/config/sysaid.yml', 'sync/config/active_directory.yml', 'sync/config/slack.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for keep_releases is 5
set :keep_releases, 5

set :delayed_job_workers, 1
set :delayed_job_prefix, :roles

namespace :deploy do
  before :starting, :stop_delayed_job do
    invoke 'delayed_job:stop'
  end

  after :finished, :start_delayed_job do
    invoke 'delayed_job:start'
  end
end
