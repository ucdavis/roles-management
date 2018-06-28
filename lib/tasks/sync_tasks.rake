require 'rake'

namespace :sync do
  desc 'Updates jobs in the queue to use the updated deploy path.'
  task :update_job_script_paths, [:updated_timestamp] => :environment do |_t, args|
    load Rails.root.join('app', 'jobs', 'sync_script_job.rb')

    Delayed::Job.all.each do |j|
      config = YAML.safe_load(j.handler)
      sync_script_path = config['sync_script']
      sync_json = JSON.parse(config['sync_json'])
      config_path = sync_json['config_path']

      sync_script_path.gsub!(/([0-9]{14})/, args[:updated_timestamp])
      config_path.gsub!(/([0-9]{14})/, args[:updated_timestamp])

      config['sync_script'] = sync_script_path
      sync_json['config_path'] = config_path

      config['sync_json'] = sync_json.to_json

      j.handler = YAML.dump(config)
      j.save
    end
  end

  desc 'Reschedules failed jobs (failed jobs will not run again by default).'
  task reschedule_failed_jobs: :environment do
    Delayed::Job.all.each do |j|
      next unless j.failed_at

      j.failed_at = nil
      j.attempts = 0
      j.run_at = Time.now
      j.save
    end
  end
end
