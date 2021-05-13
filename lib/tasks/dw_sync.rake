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
    puts 'Running dw:import_pps_departments'
    departments = DssDw.fetch_pps_departments

    departments.each do |department|
      d = Department.find_or_initialize_by(code: department['deptCode'])
      d.officialName = department['deptOfficialName']
      d.displayName = department['deptDisplayName']
      d.abbreviation = department['deptAbbrev']
      d.bou_org_oid = department['bouOrgOId']
      d.save!
    end
  end

  desc 'Import/augment user(s) with IAM data'
  task :import, [:loginid] => :environment do |_t, args|
    puts 'Running dw:import'
    loginids = []

    # TODO: What about disabling individuals not seen in a while?

    if args[:loginid]
      # Only import/update specified individual
      loginids << args[:loginid]
    else
      # Import/update known individuals and any tracked departments
      loginids = Person.all.pluck(:loginid)

      # Use DW to scan all tracked departments and grab associated login IDs
      Department.where(id: TrackedItem.where(kind: 'department').pluck(:item_id)).pluck(:code).each do |dept_code|
        dw_people_by_dept = DssDw.fetch_people_by_pps_department(dept_code)

        next unless dw_people_by_dept.present?

        loginids << dw_people_by_dept.map { |p| p['userId'] }
      end

      loginids = loginids.flatten.uniq
    end

    loginids.each { |loginid| DssDw.create_or_update_using_dw(loginid) }
  end
end
