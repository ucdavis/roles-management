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
      d.bou_org_oid = department['bouOrgOId']
      d.save!
    end
  end

  desc 'Import/augment user(s) with IAM data'
  task :import, [:loginid] => :environment do |_t, args|
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
        loginids << DssDw.fetch_people_by_pps_department(dept_code).map { |p| p['userId'] }
      end

      loginids = loginids.flatten.uniq
    end

    loginids.each { |loginid| DssDw.create_or_update_using_dw(loginid) }
  end

  desc 'Augment user(s) PPS department codes (temporary)'
  task :augment_pps, [:loginid] => :environment do |_t, args|
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
        loginids << DssDw.fetch_people_by_pps_department(dept_code).map { |p| p['userId'] }
      end

      loginids = loginids.flatten.uniq
    end

    total_people = loginids.length
    loginids.each_with_index do |loginid, i|
      puts "Augmenting PPS for '#{loginid}' #{i + 1} / #{total_people} ..."

      dw_person = DssDw.fetch_person_by_loginid(loginid)
      next unless dw_person

      p = Person.find_by(loginid: loginid)
      next unless p

      begin
        dw_person['ppsAssociations'].each do |pps_assoc_json|
          next if pps_assoc_json.nil?

          department = Department.find_by(code: pps_assoc_json['deptCode'])
          if department.nil?
            puts "\tCould not find department referenced by DW deptCode. Skipping ..."
            next
          end
          title = Title.find_by(code: pps_assoc_json['titleCode'])
          if title.nil?
            puts "\tCould not find title referenced by DW. Skipping ..."
            next
          end

          existing_assoc = p.pps_associations.find_by(
            title: title,
            department: department,
            association_rank: pps_assoc_json['assocRank'].to_i,
            position_type_code: pps_assoc_json['positionTypeCode'].to_i
          )

          if existing_assoc
            existing_assoc.admin_department = Department.find_by(code: pps_assoc_json['adminDeptCode'])
            existing_assoc.appt_department = Department.find_by(code: pps_assoc_json['apptDeptCode'])
            existing_assoc.save!
            puts "\tSuccessfully augmented PPS association with DW data"
          else
            puts "\tCould not find existing PPS association to match DW data. Skipping ..."
          end
        end
      rescue ActiveRecord::RecordNotSaved => e
        Rails.logger.error "Could not augment PPS associations for #{p.loginid}. Ensure PPS departments are imported."
        Rails.logger.error 'Exception trace:'
        Rails.logger.error e
      end
    end
  end
end
