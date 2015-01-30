require "bundler/capistrano"
require 'delayed_job_active_record'

# 'whenever' setup
set :whenever_command, "bundle exec whenever"
require "whenever/capistrano"

# 'delayed_job' setup
require "delayed/recipes"

# Use 10 background workers (the same value should be set in config/schedule.rb)
set :delayed_job_args, "-n 5"

before "deploy:restart", "delayed_job:stop"
after  "deploy:restart", "delayed_job:start"
after "deploy:stop",  "delayed_job:stop"
after "deploy:start", "delayed_job:start"

server "169.237.120.176", :web, :app, :db, primary: true

set :application, "roles-management"
set :url, "https://roles.dss.ucdavis.edu/"
set :user, "deployer"
set :deploy_to, "/home/#{user}/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

set :scm, "git"
set :repository, "git@github.com:dssit/#{application}.git"
set :branch, "master"

set :test_log, "log/capistrano.test.log"

default_run_options[:pty] = true
ssh_options[:forward_agent] = true

after "deploy", "deploy:cleanup" # keep only the last 5 releases
after "deploy", "deploy:update_last_modified_date"
after "deploy:update_code", "deploy:migrate"

before 'deploy:restart', 'deploy:empty_cache'

namespace :deploy do
  before 'deploy' do
    puts "    Running tests, please wait ..."
    unless system "bundle exec rake > #{test_log} 2>&1"
      puts "    Tests failed. Run `cat #{test_log}` to view errors."
      exit
    else
      puts "    Tests passed."
      system "rm #{test_log}"
    end
  end

  desc "Restart Passenger server"
  task :restart, roles: :app, except: {no_release: true} do
    run "touch #{current_path}/tmp/restart.txt"
  end

  desc "First-time config setup"
  task :setup_config, roles: :app do
    sudo "ln -nfs #{current_path}/config/nginx.conf /etc/nginx/sites-enabled/#{application}"
    sudo "ln -nfs #{current_path}/config/unicorn_init.sh /etc/init.d/unicorn_#{application}"
    run "mkdir -p #{shared_path}/config"
    run "mkdir -p #{shared_path}/sync/config"
    put File.read("config/database.example.yml"), "#{shared_path}/config/database.yml"
    put File.read("config/api_keys.example.yml"), "#{shared_path}/config/api_keys.yml"
    put File.read("config/ldap.example.yml"), "#{shared_path}/config/ldap.yml"
    put File.read("sync/config/active_directory.example.yml"), "#{shared_path}/sync/config/active_directory.yml"
    put File.read("sync/config/sysaid.example.yml"), "#{shared_path}/sync/config/sysaid.yml"
    put File.read("config/secret_token.example.yml"), "#{shared_path}/config/secret_token.yml"
    puts "Now edit the config files in #{shared_path}."
  end
  after "deploy:setup", "deploy:setup_config"

  desc "Symlink config from shared to the newly deployed copy"
  task :symlink_config, roles: :app do
    run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
    run "ln -nfs #{shared_path}/config/api_keys.yml #{release_path}/config/api_keys.yml"
    run "ln -nfs #{shared_path}/config/ldap.yml #{release_path}/config/ldap.yml"
    run "ln -nfs #{shared_path}/sync/config/active_directory.yml #{release_path}/sync/config/active_directory.yml"
    run "ln -nfs #{shared_path}/sync/config/sysaid.yml #{release_path}/sync/config/sysaid.yml"
    run "ln -nfs #{shared_path}/config/secret_token.yml #{release_path}/config/secret_token.yml"
  end
  after "deploy:finalize_update", "deploy:symlink_config"

  desc "Make sure local git is in sync with remote."
  task :check_revision, roles: :web do
    unless `git rev-parse HEAD` == `git rev-parse origin/master`
      puts "WARNING: HEAD is not the same as origin/master"
      puts "Run `git push` to sync changes."
      exit
    end
  end
  before "deploy", "deploy:check_revision"

  desc "Empty the main cache (changing view code does not necessarily invalidate cache_keys)"
  task :empty_cache, roles: :app do
    puts "--> Emptying cache, please wait ..."
    unless system "bundle exec rake tmp:cache:clear"
      puts "--> Emptying cache failed"
      exit
    else
      puts "--> Cache emptied"
    end
  end

  desc "Updates config/initializers/last_updated.rb with today's date"
  task :update_last_modified_date, roles: :app do
    system "bundle exec rake misc:update_last_updated"
  end
end
