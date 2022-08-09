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
    Rails.logger.info "Running task dw:import_pps_departments"
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
    Rails.logger.info "Running task dw:import"
    start_import_time = Time.now
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

    puts "Importing #{loginids.size} loginids"

    loginids.each { |loginid|
      start_time = Time.now
      begin
        DssDw.create_or_update_using_dw(loginid)
      rescue => exception
        puts "Error importing/updating #{loginid}. Skipping..."
        puts exception
      end
    }

    Rails.logger.info "Completed dw:import in #{Time.now - start_import_time}"
  end

  desc 'Import grad students by major using IAM data'
  task import_grads: :environment do
    Rails.logger.info "Running task dw:import_grads"
    sis_loginids = []
    pps_loginids = []

    Department.where(id: TrackedItem.where(kind: 'department').pluck(:item_id)).pluck(:code).each do |dept_code|
      dw_people_by_pps = DssDw.fetch_people_by_pps_department(dept_code)

      next unless dw_people_by_pps.present?

      pps_loginids << dw_people_by_pps.map { |p| p['userId'] }
    end

    pps_loginids = pps_loginids.flatten.uniq

    Major.where(id: TrackedItem.where(kind: 'gr_major').pluck(:item_id)).pluck(:gr_code).each do |major_code|
      dw_people_by_major = DssDw.fetch_people_by_major_code(major_code)

      next unless dw_people_by_major.present?

      sis_loginids << dw_people_by_major.map { |p| p['userId'] }
    end

    sis_loginids = sis_loginids.flatten.uniq

    # remove students that are already imported through PPS associations
    loginids = sis_loginids - pps_loginids

    Rails.logger.info "Starting import for #{loginids.size} logins"
    start_time = Time.now
    loginids.each { |loginid| DssDw.create_or_update_using_dw(loginid) }
    end_time = Time.now
    Rails.logger.info "Completed import for #{loginids.size} in #{end_time - start_time}s"
  end
end
