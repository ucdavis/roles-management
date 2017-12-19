namespace :dw do # rubocop:disable Metrics/BlockLength
  require 'dss_dw'
  include DssDw

  desc 'Examine user from DW based on login ID'
  task :examine, [:loginid] => :environment do |t, args|
    if args[:loginid].nil?
      STDERR.puts 'You must specify at least one login ID, e.g. bin/rake dw:import[the_loginid]'
      exit(-1)
    end

    person = DssDw.fetch_person_by_loginid(args[:loginid])

    puts "Name: #{person['person']['oFullName']}"

    require 'pp'

    pp person
  end

  desc 'Import PPS departments using DW'
  task import_pps_departments: :environment do
    departments = DssDw.fetch_pps_departments

    departments.each do |department|
      d = Department.find_or_initialize_by(code: department['deptCode'])
      d.officialName = department['deptOfficialName']
      d.displayName = department['deptDisplayName']
      d.abbreviation = department['deptAbbrev']
      d.save!
    end
  end

  desc 'Import/augment user(s) with IAM data'
  task :import, [:loginid] => :environment do |t, args|
    people = []

    if args[:loginid]
      person = Person.find_by(loginid: args[:loginid])

      if person.present?
        people << person
      else
        # We will create the person requested if they do not exist
        # so long as they exist in DW.
        dw_person = DssDw.fetch_person_by_loginid(args[:loginid])
        if dw_person.present?
          people << Person.create(loginid: dw_person['prikerbacct']['userId'])
        else
          puts "No such login ID in RM nor DW: #{args[:loginid]}"
          exit(-1)
        end
      end
    else
      people = Person.all
    end

    people.each { |p| DssDw.create_or_update_using_dw(p) }
  end
end
