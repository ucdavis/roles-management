set :application, "my.dss.ucdavis.edu_roles"

set :repository,  "git://github.com/cthielen/dss-rm.git"
set :scm, :git
set :branch, "master"

role :web, application
role :app, application
role :db,  application, :primary => true

set :user, "deploy"
set :deploy_to, "/var/www/apps/#{application}"
set :deploy_via, :remote_cache
set :use_sudo, false

namespace :deploy do
  desc "Tell Passenger to restart the app."
    task :restart do
      run "touch #{current_path}/tmp/restart.txt"
    end

    desc "Symlink shared configs and folders on each release."
    task :symlink_shared do
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      run "ln -nfs #{shared_path}/config/api_keys.yml #{release_path}/config/api_keys.yml"
      run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
    end

    desc "Sync the public/assets directory."
    task :assets do
      system "rsync -vr --exclude='.DS_Store' public/assets #{user}@#{application}:#{shared_path}/"
    end
end

after 'deploy:update_code', 'deploy:symlink_shared'
