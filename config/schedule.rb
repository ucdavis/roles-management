job_type :envcommand, 'cd :path && RAILS_ENV=:environment :task'

# Ensure our background processor starts up on reboot (10 processes)
every :reboot do
  envcommand 'bin/delayed_job -n 1 -p roles restart'
end

every 24.hours do
  rake 'dw:import_pps_departments'
  rake 'iam:import_sis_majors'
  rake 'iam:import_bous'
end

# Sync with external systems
every 12.hours do
  rake 'dw:import'
  rake 'group:audit_inherited_roles' # temporary fix until role assignments propagate correctly
  rake 'person:update_active_flag'
  rake 'person:remove_inactive'
end

every 6.hours do
  rake 'ad:resync_roles'
end
