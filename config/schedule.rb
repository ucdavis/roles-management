job_type :envcommand, 'cd :path && RAILS_ENV=:environment :task'

# Ensure our background processor starts up on reboot (10 processes)
every :reboot do
  envcommand 'script/delayed_job -n 5 restart'
end

# Run LDAP import updater every 6 hours
every 6.hours do
  rake "ldap:import"
  #envcommand 'nice -n 10 bundle exec rake ldap:import' # --silent'
end

# Sync with Active Directory every 4 hours
# TODO: Remove this test once the new sync subsystem is in place
every 1.day, :at => '1:00 am' do
  rake "ad:sync_all_users"
end
