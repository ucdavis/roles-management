require 'rake'

namespace :sync do
  desc 'Updates jobs in the queue to use the updated deploy path.'
  task :update_job_script_paths, [:updated_timestamp] => :environment do |t, args|
    require 'pp'

    load Rails.root.join('app', 'jobs', 'sync_script_job.rb')

    Delayed::Job.all.each do |j|
      config = YAML::load(j.handler)
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
end
