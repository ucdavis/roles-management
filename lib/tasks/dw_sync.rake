namespace :dw do
  require 'dss_dw'
  include DssDw

  desc 'Examine user from DW based on login ID'
  task :examine, [:loginid] => :environment do |t, args|
    if args[:loginid].nil?
      STDERR.puts 'You must specify at least one login ID, e.g. bin/rake dw:import[the_loginid]'
      exit(-1)
    end

    DssDw.fetch_person_by_loginid(args[:loginid], Rails.logger)
  end

  desc 'Augment existing users with IAM data'
  task augment: :environment do |t, args|
    Person.all.each do |p|
      puts "Processing #{p.loginid} ..."
      dw_person = DssDw.fetch_person_by_loginid(p.loginid, Rails.logger)

      next unless dw_person

      # Process the isStaff, isFaculty, etc. flags
      p.is_employee = dw_person['person']['isEmployee']
      p.is_hs_employee = dw_person['person']['isHSEmployee']
      p.is_faculty = dw_person['person']['isFaculty']
      p.is_student = dw_person['person']['isStudent']
      p.is_staff = dw_person['person']['isStaff']
      p.is_external = dw_person['person']['isExternal']

      # Process any majors (SIS associations)
      # TODO: Ensure this removes old majors, adds new majors, and does not cause unnecessary DB activity
      p.majors = dw_person['sisAssociations'].map { |sis_assoc| Major.find_or_create_by(name: sis_assoc['majorName']) }

      p.save!
    end
  end
end
