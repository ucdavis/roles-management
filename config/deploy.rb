set :application, "my.dss.ucdavis.edu"

set :repository,  "git://github.com/cthielen/dss-rm.git"
set :scm, :git
set :branch, "master"

role :web, application
role :app, application
role :db,  application, :primary => true

set :user, "deploy"
set :deploy_to, "/var/www/apps/dss-rm"
set :deploy_via, :remote_cache
set :use_sudo, false

namespace :deploy do
  desc "Tell Passenger to restart the app."
    task :restart do
      run "touch #{current_path}/tmp/restart.txt"
    end

    desc "Symlink shared configs and folders on each release."
    task :symlink_shared do
      run "mkdir -p #{shared_path}/config"
      run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
      run "ln -nfs #{shared_path}/config/api_keys.yml #{release_path}/config/api_keys.yml"
      run "ln -nfs #{shared_path}/assets #{release_path}/public/assets"
      
      # Not sure why we keep having to do this every time ... No way to install system-wide?
      run "ln -nfs #{shared_path}/vestal_versions #{release_path}/vestal_versions"
    end

    desc "Sync the public/assets directory."
    task :assets do
      system "rsync -vr --exclude='.DS_Store' public/assets #{user}@#{application}:#{shared_path}/"
    end
end

after 'deploy:update_code', 'deploy:symlink_shared'

# INSTALLME: Modify this action if you use Capistrano with your own SSH keys
ssh_options[:keys] = [File.join(ENV["HOME"], ".ssh", "id_rsa-deploy")]
