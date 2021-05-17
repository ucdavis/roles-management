job_type :envcommand, 'cd :path && RAILS_ENV=:environment :task'

# Ensure our background processor starts up on reboot (10 processes)
every :reboot do
  envcommand 'bin/delayed_job -n 1 -p roles restart'
end

#every 24.hours do
  #rake 'dw:import_pps_departments' on AWS(LS IT Legacy)
  #rake 'iam:import_sis_majors' on AWS
  #rake 'iam:import_bous' on AWS
  #rake 'group:recalculate_inherited_application_operatorships'
  #rake 'group:recalculate_inherited_application_ownerships'
#end

# Sync with external systems
# every 12.hours do
  #rake 'dw:import' on AWS
  #rake 'person:update_active_flag' on AWS(LS IT Legacy)
  #rake 'person:remove_inactive' on AWS(LS IT Legacy)
# end

#every 6.hours do
#  rake 'ad:resync_roles'
#end

#every :saturday, at: '12pm' do
#  rake 'group:audit_inherited_roles'
#end
