namespace :ldap do
  desc 'Runs the LDAP import. Takes approx. 5-10 mins.'
  task :import => :environment do
    require 'ldap'

    # Include the large lot of UCD info (dept codes, title codes, etc.)
    load 'UcdLookups.rb'

    Rails.logger.info "Beginning LDAP import."

    # Set up some manual data - would go in UcdLookups.rb but UcdLookups is auto-generated w/o this info
    basePeople = 'ou=People,dc=ucdavis,dc=edu'
    manualIncludes=['aeguyer','millerlm','djmoglen','mebalvin','mckinney','ssantam','tmheath','rnanakul','olichney','sukkim','jpokorny','bgrunewa','rabronst','kbaynes','szneena','pcmundy','wjarrold','julieluu','steichho','chuff','cmachado','alamsyah','schuang','clare186','ladyd252','aheusser','pkubitz','kshap','bbrelles','blmiss','pjdegenn','cdaniels','jyiwang','anschnei','eaisham','ralatif','cwbishop','fddiaz','jinchen','ajkou','sphan127','ndelie','weidner']
    deptTranslations = {
        'AFRICAN AMERICAN AFRICAN STDS' => 'HISTORY',
        'ASIAN AMERICAN' => 'HISTORY',
        'CALIFORNIA NATIONAL PRIMATE RESEARCH CENTER (CNPRC)' => 'PSYCHOLOGY',
        'CENTER FOR MIND & BRAIN' => 'CENTER FOR MIND AND BRAIN',
        'CENTER FOR NEUROSCIENCE' => 'PSYCHOLOGY',
        'DSS IT SHARED SERVICE CENTER' => 'DSS IT SERVICE CENTER',
        'History' => 'HISTORY',
        'HISTORY PROJECT UCD' => 'HISTORY PROJECT',
        'INTERCOLLEGIATE ATHLETICS (ICA)' => 'PHYSICAL EDUCATION PROGRAM',
        'Middle East/South Asia Stds Prog' => 'MIDDLE EAST/SOUTH ASIA PROGRAM',
        'PRIMATE CENTER' => 'PSYCHOLOGY',
        'HUMAN AND COMMUNITY DEVELOPMENT' => 'CENTER FOR MIND AND BRAIN',
        'HUMAN & COMMUNITY DEVELOPMENT' => 'CENTER FOR MIND AND BRAIN',
        'UCDHS: NEUROLOGY, DEPARTMENT OF : MED' => 'CENTER FOR MIND AND BRAIN',
        'UCDHS: NEUROLOGY, DEPARTMENT OF : MED' => 'CENTER FOR MIND AND BRAIN',
        'UCDHS: PEDS CHILD DEVELOPMENT' => 'CENTER FOR MIND AND BRAIN',
        'UCDHS: PSYCHIATRY AND BEHAVIORAL SCIENCES, DEPT OF' => 'CENTER FOR MIND AND BRAIN',
        'MED:PSYCHIATRY & BEHAV SCI' => 'CENTER FOR MIND AND BRAIN',
        'MED:PSYCHIATRY & BEHAV SCI' => 'CENTER FOR MIND AND BRAIN',
        'MED:PSYCHIATRY & BEHAV SCI' => 'CENTER FOR MIND AND BRAIN',
        'NEUROLOGY: MED' => 'CENTER FOR MIND AND BRAIN',
        'EDUCATION - PH.D.' => 'CENTER FOR MIND AND BRAIN',
        'EDUCATION, School of' => 'CENTER FOR MIND AND BRAIN',
        'BIOMEDICAL ENGINEERING' => 'CENTER FOR MIND AND BRAIN',
        'NEUROSCIENCE' => 'CENTER FOR MIND AND BRAIN',
        'ENVIRONMENTAL TOXICOLOGY' => 'ANTHROPOLOGY',
        'TEMPORARY EMPLOYMENT SERVICES (TES)' => 'TEMPORARY EMPLOYMENT SERVICES',
        'MICROBIOLOGY' => 'DSS IT SERVICE CENTER'
    }

    #
    # STEP ONE: Connect to LDAP. Query needed data.
    #

    # Retrieve LDAP passwords from config/database.yml
    ldap_settings = YAML.load_file("#{Rails.root.to_s}/config/database.yml")['ldap']

    # Connect to LDAP
    conn = LDAP::SSLConn.new( 'ldap.ucdavis.edu', 636 )
    conn.set_option( LDAP::LDAP_OPT_PROTOCOL_VERSION, 3 )
    conn.bind(dn = ldap_settings['base_dn'], password = ldap_settings['base_pw'] )

    # Build the LDAP filters
    # Build the staff filter
    staffFilterPre = '(ucdPersonAffiliation=staff*)'
    staffFilter = '(&' + staffFilterPre + '(|'
    for d in UcdLookups::DEPT_CODES.keys()
      staffFilter = staffFilter + '(ucdAppointmentDepartmentCode=' + d + ')'
    end
    staffFilter = staffFilter+'))'

    # Build the faculty filter
    facultyFilterPre = '(ucdPersonAffiliation=faculty*)'
    facultyFilter = '(&' + facultyFilterPre + '(|'
    for d in UcdLookups::DEPT_CODES.keys()
        facultyFilter = facultyFilter + '(ucdAppointmentDepartmentCode=' + d + ')'
    end
    facultyFilter = facultyFilter + '))'

    # Build the student filter
    studentFilterPre = '(ucdPersonAffiliation=student:graduate)'
    studentFilter = '(&' + studentFilterPre + '(|'
    for m in UcdLookups::MAJORS.keys()
         studentFilter = studentFilter + '(ucdStudentMajor=' + m + ')'
    end
    studentFilter = studentFilter + '))'
    
    # Build the manual filter
    manualFilter = []
    for m in manualIncludes
      manualFilter << '(uid=' + m + ')'
    end

    people = {}
    # Run the actual LDAP query
    for f in [staffFilter,facultyFilter,studentFilter] + manualFilter
        conn.search(basePeople, LDAP::LDAP_SCOPE_SUBTREE, f) do |entry|
          person = {}
          
          person["uid"] = entry.get_values('uid').to_s[2..-3]
          person["givenName"] = entry.get_values('givenName').to_s[2..-3]
          person["displayName"] = entry.get_values('displayName').to_s[2..-3]
          person["sn"] = entry.get_values('sn').to_s[2..-3]
          person["mail"] = entry.get_values('mail').to_s[2..-3]
        
          person["telephoneNumber"] = entry.get_values('telephoneNumber').to_s[2..-3]
          if person["telephoneNumber"] != nil
            person["telephoneNumber"] = person["telephoneNumber"].sub("+1 ", "").gsub(" ", "") # clean up number
          end
          person["street"] = entry.get_values('street').to_s[2..-3]
          person["title"] = entry.get_values('title').to_s[2..-3]
          person["ucdPersonAffiliation"] = entry.get_values('ucdPersonAffiliation').to_s[2..-3]
          person["ucdAppointmentTitleCode"] = entry.get_values('ucdAppointmentTitleCode').to_s[2..-3]
          person["ucdAppointmentDepartmentCode"] = entry.get_values('ucdAppointmentDepartmentCode').to_s[2..-3]
          person["eduPersonPrincipalName"] = entry.get_values('eduPersonPrincipalName').to_s[2..-3]
          person["ucdStudentMajor"] = entry.get_values('ucdStudentMajor').to_s[2..-3]
          
          if person["uid"].nil?
            next # Skip those with no UIDs
          end

          if people[person["uid"]].nil? == false
            if people[person["uid"]].to_s != person.to_s
              puts "-------------------------------------------"
              puts "Non-matching duplicate found! OLD data:"
              puts people[person["uid"]]
              puts " ---> NEW data:"
              puts person
              puts "-------------------------------------------"
            end
          end
          
          # Use the look up tables to clean up the data
          if person["ucdAppointmentDepartmentCode"]
              if UcdLookups::DEPT_CODES.keys().include? person["ucdAppointmentDepartmentCode"]
                  person['ou'] = UcdLookups::DEPT_CODES[person["ucdAppointmentDepartmentCode"]]['name']
                  person['company'] = UcdLookups::DEPT_CODES[UcdLookups::DEPT_CODES[person["ucdAppointmentDepartmentCode"]]['company']]['name']
                  person['manager'] = UcdLookups::DEPT_CODES[person["ucdAppointmentDepartmentCode"]]['manager']
              elsif person["ucdStudentMajor"]
                  if UcdLookups::MAJORS.keys().include? person["ucdStudentMajor"]
                      majorDept = UcdLookups::MAJORS[person["ucdStudentMajor"]]
                      person['ou'] = UcdLookups::DEPT_CODES[majorDept]['name']
                      person['company'] = UcdLookups::DEPT_CODES[UcdLookups::DEPT_CODES[majorDept]['company']]['name']
                      person['manager'] = UcdLookups::DEPT_CODES[majorDept]['manager']
                  end
              end
          elsif person["ucdStudentMajor"]
              if UcdLookups::MAJORS.keys().include? person["ucdStudentMajor"]
                      majorDept = UcdLookups::MAJORS[person["ucdStudentMajor"]]
                      person['ou'] = UcdLookups::DEPT_CODES[majorDept]['name']
                      person['company'] = UcdLookups::DEPT_CODES[UcdLookups::DEPT_CODES[majorDept]['company']]['name']
                      person['manager'] = UcdLookups::DEPT_CODES[majorDept]['manager']
              end
          end

          if UcdLookups::TITLE_CODES[person["ucdAppointmentTitleCode"]]
              person['title'] = UcdLookups::TITLE_CODES[person["ucdAppointmentTitleCode"]]['title']
          end
          if deptTranslations.keys().include? person['ou']
              person['ou'] = deptTranslations[person['ou']]
          end
            
          people[person["uid"]] = person
        end
    end

    # Disconnect
    conn.unbind
    
    Rails.logger.info "Completed LDAP queries. Processing ..."
    
    #
    # STEP TWO: Add people, groups, etc. to local database
    #

    Person.transaction do
      # Add people to database
      for e in people
        p = e[1]
      
        puts "-------------------"
        puts p
      
        loginid = p["eduPersonPrincipalName"].slice(0, p["eduPersonPrincipalName"].index("@"))
        # Find or create the individual
        person = Person.find_by_loginid(loginid) || Person.create(:loginid => loginid)

        person.first = p["givenName"]
        person.last = p["sn"]
        person.email = p["mail"]
        person.phone = p["telephoneNumber"]
        person.address = p["street"]
    
        if( p["ucdPersonAffiliation"] == "student:graduate" )
          # Graduate student 'ou's are determined not by the ou entry but by the 
          ou = Ou.find(:first, :conditions => [ "lower(name) = ?", p["ucdStudentMajor"].downcase ]) || Ou.create(:name => p["ucdStudentMajor"])
          # The dept code & manager won't be set here but should get updated once a faculty/staff comes along for that dept
          ou.save!
        else
          unless p["ou"].nil?
            # Not a graduate student: p["ou"] entry is reliable
            ou = Ou.find(:first, :conditions => [ "lower(name) = ?", p["ou"].downcase ]) || Ou.create(:name => p["ou"])
            # Assume dept codes match name strings
            ou.code = p["ucdAppointmentDepartmentCode"]
          end
      
          unless UcdLookups::DEPT_CODES[p["ucdAppointmentDepartmentCode"]].nil?
            # Find or create the manager (if we see the rest of their data later, it will be updated accordingly)
            manager = Person.find_by_loginid(UcdLookups::DEPT_CODES[p["ucdAppointmentDepartmentCode"]]["manager"]) || Person.create(:loginid => UcdLookups::DEPT_CODES[p["ucdAppointmentDepartmentCode"]]["manager"])
            # Avoid duplicate managers
            unless ou.managers.exists? manager
              ou.managers << manager
            end
            
            person.managers << manager
          else
            # Dept code doesn't exist
            unless p["ucdAppointmentDepartmentCode"].nil?
              puts "Could not find a dept_code for " + p["ucdAppointmentDepartmentCode"]
            end
          end
      
          ou.save!
        end
    
        person.ous << ou
    
        unless p["title"].nil?
          # Set title, creating it if necessary
          title = Title.find_or_create_by_name(p["title"])
          # Update the title code information, if necessary
          if title.code.nil?
            title.code = p["ucdAppointmentTitleCode"]
            title.save
          end
          person.title = title
        end
      
        unless p["ucdPersonAffiliation"].nil?
          # Set the affiliation, creating it if necessary
          affiliation = Affiliation.find_or_create_by_name(p["ucdPersonAffiliation"])
          person.affiliations << affiliation
        end
    
        person.status = true
        person.preferred_name = p["displayName"]
    
        if person.valid? == false
          Rails.logger.info "Unable to create or update persion with ID #{person.id}"
        else
          Rails.logger.info "Creating or updated persion with ID #{person.id}"
          person.save!
        end
      end
    end
    
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
