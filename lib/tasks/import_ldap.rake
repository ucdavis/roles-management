namespace :ldap do
  desc 'Runs the LDAP import. Takes approx. 5-10 mins.'
  task :import, :loginid do |t, args|
    require 'ldap'
    require 'stringio'
    
    Rake::Task['environment'].invoke

    # Keep a log to e-mail to the admins
    log = StringIO.new

    # Include the large lot of UCD info (dept codes, title codes, etc.)
    load 'UcdLookups.rb'

    timestamp_start = Time.now

    log << "Beginning LDAP import\n\n"

    #
    # STEP ONE: Connect to LDAP. Query needed data.
    #

    # Retrieve LDAP passwords from config/database.yml
    ldap_settings = YAML.load_file("#{Rails.root.to_s}/config/database.yml")['ldap']

    # Connect to LDAP
    conn = LDAP::SSLConn.new( 'ldap.ucdavis.edu', 636 )
    conn.set_option( LDAP::LDAP_OPT_PROTOCOL_VERSION, 3 )
    conn.bind(dn = ldap_settings['base_dn'], password = ldap_settings['base_pw'] )

    log << "Connected to ldap.ucdavis.edu on port 636, LDAP protocol version 3.\n\n"

    people = {}

    log << "Using the following LDAP queries:\n"
    
    # If they specified a loginid, only import them, otherwise, do everybody
    unless args[:loginid].nil?
      # Specified a loginid
      staffFilter = ''
      facultyFilter = ''
      studentFilter = ''
      manualFilter = []
      manualFilter << '(uid=' + args[:loginid] + ')'
      
      log << "\t" + manualFilter.join(",") + "\n"
    else
      # Did not specify a loginid - import everyone
      
      # Build needed LDAP filters
      # Staff filter
      staffFilter = '(&(ucdPersonAffiliation=staff*)(|'
      for d in UcdLookups::DEPT_CODES.keys()
        staffFilter = staffFilter + '(ucdAppointmentDepartmentCode=' + d + ')'
      end
      staffFilter = staffFilter + '))'

      log << "\t" + staffFilter + "\n"

      # Faculty filter
      facultyFilter = '(&(ucdPersonAffiliation=faculty*)(|'
      for d in UcdLookups::DEPT_CODES.keys()
          facultyFilter = facultyFilter + '(ucdAppointmentDepartmentCode=' + d + ')'
      end
      facultyFilter = facultyFilter + '))'

      log << "\t" + facultyFilter + "\n"

      # Student filter
      studentFilter = '(&(ucdPersonAffiliation=student:graduate)(|'
      for m in UcdLookups::MAJORS.keys()
           studentFilter = studentFilter + '(ucdStudentMajor=' + m + ')'
      end
      studentFilter = studentFilter + '))'
      
      log << "\t" + studentFilter + "\n"
    
      # Manual filter
      manualFilter = []
      for m in UcdLookups::MANUAL_INCLUDES
        manualFilter << '(uid=' + m + ')'
      end
      
      log << "\t" + manualFilter.join(",") + "\n"
    end

    log << "\n"

    # Query LDAP
    Person.transaction do
      for f in [staffFilter,facultyFilter,studentFilter] + manualFilter
        record_log = StringIO.new # this log may or may not be added to the master 'log' depending on data sync states
        
        unless f.length == 0
          conn.search(ldap_settings['search_dn'], LDAP::LDAP_SCOPE_SUBTREE, f) do |entry|
            # TODO: Instead of merely setting fields, check if they've changed!
            
            # First, determine their login ID from the principal name
            eduPersonPrincipalName = entry.get_values('eduPersonPrincipalName').to_s[2..-3]
            if eduPersonPrincipalName.nil?
              # If they don't have an eduPersonPrincipalName, we'll take the uid, else we'll just log this entry and skip it
              unless entry.get_values('uid').to_s[2..-3].nil?
                loginid = entry.get_values('uid').to_s[2..-3]
              else
                # Give up
                log << "Warning: Ignoring LDAP entry with no eduPersonPrincipalName and no uid. ucdPersonUUID: " + entry.get_values('ucdPersonUUID').to_s + "\n"
                next
              end
            else
              loginid = eduPersonPrincipalName.slice(0, eduPersonPrincipalName.index("@"))
            end
            
            record_log << "Processing LDAP record for #{loginid}\n"
            
            # Find or create the Person object
            p = Person.find_by_loginid(loginid) || Person.create(:loginid => loginid)

            p.first = entry.get_values('givenName')[0]
            p.last = entry.get_values('sn')[0]
            p.email = entry.get_values('mail').to_s[2..-3]
            p.phone = entry.get_values('telephoneNumber').to_s[2..-3]
            unless p.phone.nil?
              p.phone = p.phone.sub("+1 ", "").gsub(" ", "") # clean up number
            end
            p.address = entry.get_values('street').to_s[2..-3]
            p.status = true
            p.preferred_name = entry.get_values('displayName')[0]
            
            # A person may have multiple affiliations
            entry.get_values('ucdPersonAffiliation').each do |affiliation_name|
              affiliation = Affiliation.find_or_create_by_name(affiliation_name)
              unless p.affiliations.include? affiliation
                p.affiliations << affiliation
              end
            end
            
            # Set title: take the original unless there is a translation from UcdLookups
            title = entry.get_values('title').to_s[2..-3]
            ucdAppointmentTitleCode = entry.get_values('ucdAppointmentTitleCode').to_s[2..-3]
            if UcdLookups::TITLE_CODES[ucdAppointmentTitleCode]
              title = UcdLookups::TITLE_CODES[ucdAppointmentTitleCode]['title']
            end
            title = Title.find_or_create_by_name(title)
            # Update the title code information, if necessary
            if title.code.nil?
              title.code = ucdAppointmentTitleCode
              title.save
            end
            p.title = title
            
            ucdAppointmentDepartmentCode = entry.get_values('ucdAppointmentDepartmentCode').to_s[2..-3]
            ucdStudentMajor = entry.get_values('ucdStudentMajor').to_s[2..-3]
          
            # Use UcdLookups to clean up the data
            if ucdAppointmentDepartmentCode
              if UcdLookups::DEPT_CODES.keys().include? ucdAppointmentDepartmentCode
                ou = UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]['name']
                company = UcdLookups::DEPT_CODES[UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]['company']]['name']
                manager = UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]['manager']
              elsif ucdStudentMajor
                if UcdLookups::MAJORS.keys().include? ucdStudentMajor
                  majorDept = UcdLookups::MAJORS[ucdStudentMajor]
                  ou = UcdLookups::DEPT_CODES[majorDept]['name']
                  company = UcdLookups::DEPT_CODES[UcdLookups::DEPT_CODES[majorDept]['company']]['name']
                  manager = UcdLookups::DEPT_CODES[majorDept]['manager']
                end
              end
            elsif ucdStudentMajor
              if UcdLookups::MAJORS.keys().include? ucdStudentMajor
                majorDept = UcdLookups::MAJORS[ucdStudentMajor]
                ou = UcdLookups::DEPT_CODES[majorDept]['name']
                company = UcdLookups::DEPT_CODES[UcdLookups::DEPT_CODES[majorDept]['company']]['name']
                manager = UcdLookups::DEPT_CODES[majorDept]['manager']
              end
            end

            if UcdLookups::DEPT_TRANSLATIONS.keys().include? ou
              ou = UcdLookups::DEPT_TRANSLATIONS[ou]
            end
            
            if( p.affiliations.collect { |x| x.name }.include? "student:graduate" )
              # Graduate student 'ou's are determined not by the ou entry but by the 
              ou = Group.find(:first, :conditions => [ "lower(name) = ?", ucdStudentMajor.downcase ]) || Group.create(:name => ucdStudentMajor)
              # The dept code & manager won't be set here but should get updated once a faculty/staff comes along for that dept
              ou.save!
            else
              unless ou.nil?
                # Not a graduate student: p["ou"] entry is reliable
                ou = Group.find(:first, :conditions => [ "lower(name) = ?", ou.downcase ]) || Group.create(:name => ou)
                # Assume dept codes match name strings
                if ou.code.nil?
                  ou.code = ucdAppointmentDepartmentCode
                end
                ou.save!
              end
      
              unless UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode].nil?
                # Find or create the manager (if we see the rest of their data later, it will be updated accordingly)
                manager = Person.find_by_loginid(UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]["manager"]) || Person.create(:loginid => UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]["manager"])
                # Avoid duplicate managers
                unless ou.owners.exists? manager
                  ou.owners << manager
                end
            
                p.managers << manager
              else
                # Dept code doesn't exist
                unless ucdAppointmentDepartmentCode.nil?
                  record_log << "\tWarning: Could not find a deptartment code translation for " + ucdAppointmentDepartmentCode + "\n"
                end
              end
            end
        
            unless p.groups.include? ou or ou.nil?
              p.groups << ou
            end
    
            if p.valid? == false
              record_log << "\tUnable to create or update persion with loginid #{p.loginid}\n"
              record_log << "\tReason(s):\n"
              p.errors.messages.each do |field,reason|
                record_log << "\t\tField #{field} #{reason}\n"
              end
            else
              if p.changed? == false
                record_log << "\tNo changes for #{p.loginid}\n"
              else
                record_log << "\tUpdating the following for #{p.loginid}:\n"
                p.changes.each do |field,changes|
                  record_log << "\t\t#{field}: #{changes[0]} -> #{changes[1]}\n"
                end
                
                # Save this record log to the master log as it contains changes
                log << record_log.string
              end
              p.save!
            end
          end
        end
      end
    end

    # Disconnect
    conn.unbind
    
    log << "Finished LDAP import.\n"
    
    timestamp_finish = Time.now
    
    log << "LDAP import took " + (timestamp_finish - timestamp_start).to_s + "s\n"
    
    # Email the log
    WheneverMailer.ldap_report(log.string).deliver!
  end
  
  desc 'Erases any data that might be introduced by LDAP. Be very careful and back up your database!'
  task :erase => :environment do
    if Rails.env != "production"
      Person.destroy_all
      Group.destroy_all
      RoleAssignment.destroy_all
      Affiliation.destroy_all
      GroupRule.delete_all
      AffiliationAssignment.destroy_all
      PersonManagerAssignment.destroy_all
      Classification.destroy_all
      Title.destroy_all
      TemplateAssignment.destroy_all
      puts "Be sure to assign roles if you re-import the directory."
    else
      puts "This task is purposefully disabled in production mode."
    end
  end
end
