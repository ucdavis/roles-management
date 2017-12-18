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

  desc 'Import SIS majors using DW'
  task import_sis_majors: :environment do
    majors = DssDw.fetch_sis_majors

    majors.each do |major|
      Major.find_or_create_by(name: major['majorName'])
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
          p = Person.create(loginid: dw_person['prikerbacct']['userId'])
          people << p
        else
          puts "No such login ID in RM nor DW: #{args[:loginid]}"
          exit(-1)
        end
      end
    else
      people = Person.all
    end

    people.each_with_index do |p, i|
      puts "Processing #{p.loginid} (#{i + 1} / #{people.length}) ..."
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
      begin
        existing_sis_assocs = p.sis_associations.map do |assoc|
          {
            id: assoc.id,
            major: assoc.major.name,
            association_rank: assoc.association_rank,
            level_code: assoc.level_code
          }
        end
        dw_person['sisAssociations'].each do |sis_assoc_json|
          if existing_sis_assocs.reject! do |assoc|
            assoc[:major] == sis_assoc_json['majorName'] &&
            assoc[:association_rank] == sis_assoc_json['assocRank'].to_i &&
            assoc[:level_code] == sis_assoc_json['levelCode']
          end == nil
            puts "#{p.loginid} does not have SIS association, creating ..."
            SisAssociation.create!(entity_id: p.id,
                                   major: Major.find_by(name: sis_assoc_json['majorName']),
                                   association_rank: sis_assoc_json['assocRank'].to_i,
                                   level_code: sis_assoc_json['levelCode'])
          else
            puts "#{p.loginid} already has SIS association, ignoring ..."
          end
        end

        existing_sis_assocs.each do |assoc|
          puts "#{p.loginid} no longer appears to have SIS association, destroying ..."
          p.sis_associations.destroy(SisAssociation.find_by(id: assoc[:id]))
        end
      rescue ActiveRecord::RecordNotSaved => e
        Rails.logger.error "Could not save SIS associations for #{p.loginid}. Exception trace:"
        Rails.logger.error e
      end

      begin
        # Process any PPS affiliations
        existing_pps_assocs = p.pps_associations.map do |assoc|
          {
            id: assoc.id,
            title: assoc.title.code,
            department: assoc.department.code,
            association_rank: assoc.association_rank,
            position_type_code: assoc.position_type_code
          }
        end
        dw_person['ppsAssociations'].each do |pps_assoc_json|
          if existing_pps_assocs.reject! do |assoc|
            assoc[:title] == pps_assoc_json['titleCode'] &&
            assoc[:department] == pps_assoc_json['deptCode'] &&
            assoc[:association_rank] == pps_assoc_json['assocRank'].to_i &&
            assoc[:position_type_code] == pps_assoc_json['positionTypeCode'].to_i
          end == nil
            puts "#{p.loginid} does not have PPS association, creating ..."
            PpsAssociation.create!(person_id: p.id,
                                   title: Title.find_by(code: pps_assoc_json['titleCode']),
                                   department: Department.find_by(code: pps_assoc_json['deptCode']),
                                   association_rank: pps_assoc_json['assocRank'].to_i,
                                   position_type_code: pps_assoc_json['positionTypeCode'].to_i)
          else
            puts "#{p.loginid} already has PPS association, ignoring ..."
          end
        end

        existing_pps_assocs.each do |assoc|
          puts "#{p.loginid} no longer appears to have PPS association, destroying ..."
          p.pps_associations.destroy(PpsAssociation.find_by(id: assoc[:id]))
        end
      rescue ActiveRecord::RecordNotSaved => e
        Rails.logger.error "Could not save PPS associations for #{p.loginid}. Ensure PPS departments are imported."
        Rails.logger.error 'Exception trace:'
        Rails.logger.error e
      end

      p.save!
    end
  end
end
