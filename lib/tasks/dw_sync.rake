namespace :dw do
  require 'dss_dw'
  include DssDw

  desc 'Import users from DW based on login ID'
  task :import, [:loginid] => :environment do |t, args|
    if args[:loginid].nil?
      STDERR.puts 'You must specify at least one login ID, e.g. bin/rake dw:import[the_loginid]'
      exit(-1)
    end

    DssDw.fetch_person_by_loginid(args[:loginid], Rails.logger)
  end
end
