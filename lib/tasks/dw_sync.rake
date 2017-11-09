namespace :dw do
  require 'dss_dw'
  include DssDw

  desc 'Examine user from DW based on login ID'
  task :examine, [:loginid] => :environment do |t, args|
    if args[:loginid].nil?
      STDERR.puts 'You must specify at least one login ID, e.g. bin/rake dw:import[the_loginid]'
      exit(-1)
    end

    DssDw.fetch_person_by_loginid(args[:loginid])
  end

  desc 'Import PPS departments with IAM data'
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

  desc 'Augment existing users with IAM data'
  task :augment, [:loginid] => :environment do |t, args|
    people = []

    if args[:loginid]
      people << Person.find_by(loginid: args[:loginid])
    else
      people = Person.all
    end

    people.each_with_index do |p, i|
      puts "Processing #{p.loginid} (#{i+1} / #{people.length}) ..."
      dw_person = DssDw.fetch_person_by_loginid(p.loginid)

      next unless dw_person

      # Process the isStaff, isFaculty, etc. flags
      p.is_employee = dw_person['person']['isEmployee']
      p.is_hs_employee = dw_person['person']['isHSEmployee']
      p.is_faculty = dw_person['person']['isFaculty']
      p.is_student = dw_person['person']['isStudent']
      p.is_staff = dw_person['person']['isStaff']
      p.is_external = dw_person['person']['isExternal']
      p.iam_id = dw_person['person']['iamId'].to_i

      # Process any majors (SIS associations)
      # p.majors = dw_person['sisAssociations'].map { |sis_assoc| Major.find_or_create_by(name: sis_assoc['majorName']) }
      begin
        p.sis_associations = dw_person['sisAssociations'].map { |sis_assoc_json|
          SisAssociation.find_or_create_by(entity_id: p.id,
                                           major: Major.find_by(name: sis_assoc_json['majorName']),
                                           association_rank: sis_assoc_json['assocRank'].to_i,
                                           level_code: sis_assoc_json['levelCode'])
        }
      rescue ActiveRecord::RecordNotSaved => e
        Rails.logger.error "Could not save SIS associations for #{p.loginid}. Exception trace:"
        Rails.logger.error e
      end

      begin
        # Process any PPS affiliations
        p.pps_associations = dw_person['ppsAssociations'].map { |pps_assoc_json|
          PpsAssociation.find_or_create_by(person_id: p.id,
                                           title: Title.find_by(code: pps_assoc_json['titleCode']),
                                           department: Department.find_by(code: pps_assoc_json['deptCode']),
                                           association_rank: pps_assoc_json['assocRank'].to_i,
                                           position_type_code: pps_assoc_json['positionTypeCode'].to_i)
        }
      rescue ActiveRecord::RecordNotSaved => e
        Rails.logger.error "Could not save PPS associations for #{p.loginid}. Ensure PPS departments are imported. Exception trace:"
        Rails.logger.error e
      end

      p.save!
    end
  end
end
