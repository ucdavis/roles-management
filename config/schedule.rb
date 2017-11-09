job_type :envcommand, 'cd :path && RAILS_ENV=:environment :task'

# Ensure our background processor starts up on reboot (10 processes)
every :reboot do
  envcommand 'bin/delayed_job -n 10 -p roles restart'
end

every 24.hours do
  rake 'dw:import_pps_departments'
end

# Run LDAP import updater every 6 hours
every 6.hours do
  rake 'ldap:import'
end
