job_type :envcommand, 'cd :path && RAILS_ENV=:environment :task'

# Ensure our background processor starts up on reboot (20 processes)
every :reboot do
  envcommand 'script/delayed_job -n 20 restart'
end

# Run LDAP import updater every 6 hours
every 6.hours do
  rake "ldap:import"
  #envcommand 'nice -n 10 bundle exec rake ldap:import' # --silent'
end

# Sync with Active Directory every 4 hours
every 4.hours do
  rake "ad:sync_all_users"
end

# Temporary test
every 2.minutes do
  rake "temp_tasks:throw_exception"
end
