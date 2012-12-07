# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

job_type :envcommand, 'cd :path && RAILS_ENV=:environment :task'

# Ensure our background processor starts up on reboot
every :reboot do
  envcommand 'script/delayed_job restart'
end

# Run LDAP import updater every 24 hours at 2am
every :day, :at => "2am" do
  rake "ldap:import"
end

# Sync with Active Directory every 24 hours at 2:15am (LDAP usually only takes 2-3 mins)
every :day, :at => "2:15 am" do
  rake "ad:sync"
end
