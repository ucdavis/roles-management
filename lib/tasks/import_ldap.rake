namespace :ldap do
  desc 'Runs the LDAP import. Takes approx. 5-10 mins.'
  task :import, :loginid do |t, args|
    require 'ldap'
    
    Rake::Task['environment'].invoke

    # Include the large lot of UCD info (dept codes, title codes, etc.)
    load 'UcdLookups.rb'

    Rails.logger.info "Beginning LDAP import."

    #
    # STEP ONE: Connect to LDAP. Query needed data.
    #

    # Retrieve LDAP passwords from config/database.yml
    ldap_settings = YAML.load_file("#{Rails.root.to_s}/config/database.yml")['ldap']

    # Connect to LDAP
    conn = LDAP::SSLConn.new( 'ldap.ucdavis.edu', 636 )
    conn.set_option( LDAP::LDAP_OPT_PROTOCOL_VERSION, 3 )
    conn.bind(dn = ldap_settings['base_dn'], password = ldap_settings['base_pw'] )

    people = {}
    
    # If they specified a loginid, only import them, otherwise, do everybody
    unless args[:loginid].nil?
      # Specified a loginid
      staffFilter = ''
      facultyFilter = ''
      studentFilter = ''
      manualFilter = []
      manualFilter << '(uid=' + args[:loginid] + ')'
    else
      # Did not specify a loginid - import everyone
      
      # Build needed LDAP filters
      # Staff filter
      staffFilter = '(&(ucdPersonAffiliation=staff*)(|'
      for d in UcdLookups::DEPT_CODES.keys()
        staffFilter = staffFilter + '(ucdAppointmentDepartmentCode=' + d + ')'
      end
      staffFilter = staffFilter + '))'

      # Faculty filter
      facultyFilter = '(&(ucdPersonAffiliation=faculty*)(|'
      for d in UcdLookups::DEPT_CODES.keys()
          facultyFilter = facultyFilter + '(ucdAppointmentDepartmentCode=' + d + ')'
      end
      facultyFilter = facultyFilter + '))'

      # Student filter
      studentFilter = '(&(ucdPersonAffiliation=student:graduate)(|'
      for m in UcdLookups::MAJORS.keys()
           studentFilter = studentFilter + '(ucdStudentMajor=' + m + ')'
      end
      studentFilter = studentFilter + '))'
    
      # Manual filter
      manualFilter = []
      for m in UcdLookups::MANUAL_INCLUDES
        manualFilter << '(uid=' + m + ')'
      end
    end

    # Query LDAP
    Person.transaction do
      for f in [staffFilter,facultyFilter,studentFilter] + manualFilter
        unless f.length == 0
          conn.search(ldap_settings['search_dn'], LDAP::LDAP_SCOPE_SUBTREE, f) do |entry|
            
            # TODO: Instead of merely setting fields, check if they've changed!
            
            # First, determine their login ID from the principal name
            eduPersonPrincipalName = entry.get_values('eduPersonPrincipalName')[0]
            loginid = eduPersonPrincipalName.slice(0, eduPersonPrincipalName.index("@"))
            
            # Find or create the Person object
            p = Person.find_by_loginid(loginid) || Person.create(:loginid => loginid)

            p.first = entry.get_values('givenName')[0]
            p.last = entry.get_values('sn')[0]
            p.email = entry.get_values('mail')[0]
            p.phone = entry.get_values('telephoneNumber')[0]
            unless p.phone.nil?
              p.phone = p.phone.sub("+1 ", "").gsub(" ", "") # clean up number
            end
            p.address = entry.get_values('street')[0]
            person.status = true
            person.preferred_name = entry.get_values('displayName')[0]
            
            # A person may have multiple affiliations
            entry.get_values('ucdPersonAffiliation').each do |affiliation_name|
              affiliation = Affiliation.find_or_create_by_name(affiliation_name)
              person.affiliations << affiliation
            end
            
            # Set title: take the original unless there is a translation from UcdLookups
            title = entry.get_values('title')[0]
            ucdAppointmentTitleCode = entry.get_values('ucdAppointmentTitleCode')[0]
            if UcdLookups::TITLE_CODES[ucdAppointmentTitleCode]
              title = UcdLookups::TITLE_CODES[ucdAppointmentTitleCode]['title']
            end
            title = Title.find_or_create_by_name(title)
            # Update the title code information, if necessary
            if title.code.nil?
              title.code = ucdAppointmentTitleCode
              title.save
            end
            person.title = title
            
            ucdAppointmentDepartmentCode = entry.get_values('ucdAppointmentDepartmentCode')[0]
            ucdStudentMajor = entry.get_values('ucdStudentMajor')[0]
          
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
            
            if( ucdPersonAffiliation == "student:graduate" )
              # Graduate student 'ou's are determined not by the ou entry but by the 
              ou = Ou.find(:first, :conditions => [ "lower(name) = ?", ucdStudentMajor.downcase ]) || Ou.create(:name => ucdStudentMajor)
              # The dept code & manager won't be set here but should get updated once a faculty/staff comes along for that dept
              ou.save!
            else
              unless ou.nil?
                # Not a graduate student: p["ou"] entry is reliable
                ou = Ou.find(:first, :conditions => [ "lower(name) = ?", ou.downcase ]) || Ou.create(:name => ou)
                # Assume dept codes match name strings
                ou.code = ucdAppointmentDepartmentCode
              end
      
              unless UcdLookups::DEPT_CODES[p["ucdAppointmentDepartmentCode"]].nil?
                # Find or create the manager (if we see the rest of their data later, it will be updated accordingly)
                manager = Person.find_by_loginid(UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]["manager"]) || Person.create(:loginid => UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]["manager"])
                # Avoid duplicate managers
                unless ou.managers.exists? manager
                  ou.managers << manager
                end
            
                person.managers << manager
              else
                # Dept code doesn't exist
                unless ucdAppointmentDepartmentCode.nil?
                  puts "Could not find a dept_code for " + ucdAppointmentDepartmentCode
                end
              end
      
              ou.save!
            end
        
            unless person.ous.include? ou
              person.ous << ou
            end
    
            if person.valid? == false
              Rails.logger.info "Unable to create or update persion with ID #{person.id}"
            else
              Rails.logger.info "Creating or updated persion with ID #{person.id}"
              person.save!
            end
          end
        end
      end
    end

    # Disconnect
    conn.unbind
    
    Rails.logger.info "Finished LDAP import."
  end
  
  desc 'Erases any data that might be introduced by LDAP. Be very careful and back up your database!'
  task :erase => :environment do
    if Rails.env != "production"
      Person.destroy_all
      Group.destroy_all
      Ou.destroy_all
      RoleAssignment.destroy_all
      OuAssignment.destroy_all
      ApplicationOuAssignment.destroy_all
      Affiliation.destroy_all
      GroupRule.delete_all
      OuChildrenAssignment.destroy_all
      OuManagerAssignment.destroy_all
      AffiliationAssignment.destroy_all
      PersonManagerAssignment.destroy_all
      Classification.destroy_all
      #ClassificationTitles.destroy_all
      Title.destroy_all
      puts "Be sure to assign roles if you re-import the directory."
    end
  end
end
