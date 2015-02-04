job_type :envcommand, 'cd :path && RAILS_ENV=:environment :task'

# Ensure our background processor starts up on reboot (5 processes)
every :reboot do
  envcommand 'script/delayed_job -n 5 restart'
end

# Run LDAP import updater every 6 hours
every 6.hours do
  rake "ldap:import"
  #envcommand 'nice -n 10 bundle exec rake ldap:import' # --silent'
end
