job_type :envcommand, 'cd :path && RAILS_ENV=:environment :task'

# Ensure our background processor starts up on reboot
every :reboot do
  envcommand 'script/delayed_job restart'
end

every 30.minutes do
  rake "exception:generate"
end

# Run LDAP import updater every 4 hours
every 4.hours do
  rake "ldap:import"
  #envcommand 'nice -n 10 bundle exec rake ldap:import' # --silent'
end

# Sync with Active Directory every 24 hours at 2:30am (LDAP usually only takes 2-3 mins)
every 4.hours do
  rake "ad:sync_all_users"
end
