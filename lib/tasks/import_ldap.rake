namespace :ldap do
  desc 'Runs the LDAP import. Takes approx. 5-10 mins.'
  task :import => :environment do
    require 'ldap'

    # Include the large lot of UCD info (dept codes, title codes, etc.)
    load 'UcdLookups.rb'

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
    attributes = ['uid','givenName','sn','mail','telephoneNumber','street','ou','title','ucdPersonAffiliation','displayName','ucdStudentMajor','ucdAppointmentDepartmentCode','company','manager','ucdAppointmentTitleCode','principal_name','title_code','dept_code']

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

    people = []
    # Run the actual LDAP query
    for f in [staffFilter,facultyFilter,studentFilter]
        conn.search(basePeople, LDAP::LDAP_SCOPE_SUBTREE, f) do |entry|
          person = {}
          person["uid"] = entry.get_values('uid').to_s[2..-3]
          person["givenName"] = entry.get_values('givenName').to_s[2..-3]
          person["sn"] = entry.get_values('sn').to_s[2..-3]
          person["mail"] = entry.get_values('mail').to_s[2..-3]
        
          person["telephoneNumber"] = entry.get_values('telephoneNumber').to_s[2..-3]
          if person["telephoneNumber"] != nil
            person["telephoneNumber"] = person["telephoneNumber"].sub("+1 ", "").gsub(" ", "") # clean up number
          end
          person["street"] = entry.get_values('street').to_s[2..-3]
          person["ou"] = entry.get_values('ou').to_s[2..-3]
          person["title"] = entry.get_values('title').to_s[2..-3]
          person["ucdPersonAffiliation"] = entry.get_values('ucdPersonAffiliation').to_s[2..-3]
          person["title_code"] = entry.get_values('ucdAppointmentTitleCode').to_s[2..-3]
          person["dept_code"] = entry.get_values('ucdAppointmentDepartmentCode').to_s[2..-3]
          person["principal_name"] = entry.get_values('eduPersonPrincipalName').to_s[2..-3]
          person["ucdStudentMajor"] = entry.get_values('ucdStudentMajor').to_s[2..-3]

          people << person
        end
    end

    # Additional query for manual includes
    for u in manualIncludes
        conn.search(basePeople, LDAP::LDAP_SCOPE_SUBTREE, '(uid=' + u + ')') do |entry|
          person = {}
          person["uid"] = entry.get_values('uid').to_s[2..-3]
          person["givenName"] = entry.get_values('givenName').to_s[2..-3]
          person["sn"] = entry.get_values('sn').to_s[2..-3]
          person["mail"] = entry.get_values('mail').to_s[2..-3]
          person["telephoneNumber"] = entry.get_values('telephoneNumber').to_s[2..-3]
          if person["telephoneNumber"] != nil
            person["telephoneNumber"] = person["telephoneNumber"].sub("+1 ", "").gsub(" ", "") # clean up number
          end
          person["street"] = entry.get_values('street').to_s[2..-3]
          person["ou"] = entry.get_values('ou').to_s[2..-3]
          person["title"] = entry.get_values('title').to_s[2..-3]
          person["ucdPersonAffiliation"] = entry.get_values('ucdPersonAffiliation').to_s[2..-3]
          person["title_code"] = entry.get_values('ucdAppointmentTitleCode').to_s[2..-3]
          person["dept_code"] = entry.get_values('ucdAppointmentDepartmentCode').to_s[2..-3]
          person["principal_name"] = entry.get_values('eduPersonPrincipalName').to_s[2..-3]
          person["ucdStudentMajor"] = entry.get_values('ucdStudentMajor').to_s[2..-3]

          people << person
        end
    end
  
    #
    # STEP TWO: Filter received LDAP data down to only what's necessary.
    #
  
    # Filter to only have unique individuals
    uniquePeople = []
    uuids = []
    for p in people
        if p["uid"]
          if ! uuids.include? p["uid"]
              uuids << p["uid"]
              uniquePeople << p
          end
        end
    end

    finalPeople = []
    for p in uniquePeople
        person = {}
        for a in attributes
            if p[a]
                person[a] = p[a]
            elsif
                person[a] = ''
            end
        end

        if p["ucdAppointmentDepartmentCode"]
            if UcdLookups::DEPT_CODES.keys().include? p["ucdAppointmentDepartmentCode"]
                person['ou'] = UcdLookups::DEPT_CODES[p["ucdAppointmentDepartmentCode"]]['name']
                person['company'] = UcdLookups::DEPT_CODES[UcdLookups::DEPT_CODES[p["ucdAppointmentDepartmentCode"]]['company']]['name']
                person['manager'] = UcdLookups::DEPT_CODES[p["ucdAppointmentDepartmentCode"]]['manager']
            elsif p["ucdStudentMajor"]
                if UcdLookups::MAJORS.keys().include? p["ucdStudentMajor"]
                    majorDept = UcdLookups::MAJORS[p["ucdStudentMajor"]]
                    person['ou'] = UcdLookups::DEPT_CODES[majorDept]['name']
                    person['company'] = UcdLookups::DEPT_CODES[UcdLookups::DEPT_CODES[majorDept]['company']]['name']
                    person['manager'] = UcdLookups::DEPT_CODES[majorDept]['manager']
                end
            end
        elsif p["ucdStudentMajor"]
            if UcdLookups::MAJORS.keys().include? p["ucdStudentMajor"]
                    majorDept = UcdLookups::MAJORS[p["ucdStudentMajor"]]
                    person['ou'] = UcdLookups::DEPT_CODES[majorDept]['name']
                    person['company'] = UcdLookups::DEPT_CODES[UcdLookups::DEPT_CODES[majorDept]['company']]['name']
                    person['manager'] = UcdLookups::DEPT_CODES[majorDept]['manager']
            end
        end

        if p["ucdAppointmentTitleCode"]
            #print p["ucdAppointmentTitleCode"]
            #print UcdLookups::TITLE_CODES[p["ucdAppointmentTitleCode"]]['title']
            person['title'] = UcdLookups::TITLE_CODES[p["ucdAppointmentTitleCode"]]['title']
        end
        if deptTranslations.keys().include? person['ou']
            person['ou'] = deptTranslations[person['ou']]
        end
        if not person['company']
            person['company'] = ''
        end
        if not person['manager']
            person['manager'] = ''
        end

        finalPeople << person
    end

    # Disconnect
    conn.unbind
  
    #
    # STEP THREE: Add people, groups, etc. to local database
    #

    # Add people to database
    for f in finalPeople
      # Find or create the individual
      person = Person.find_by_loginid(f["principal_name"].slice(0, f["principal_name"].index("@"))) || Person.create(:loginid => f["principal_name"].slice(0, f["principal_name"].index("@")))

      # Only set to attributes found in LDAP if the attributes aren't already set (i.e. blank)
      unless not person.first.nil?
        person.first = f["givenName"]
      end
      unless not person.last.nil?
        person.last = f["sn"]
      end
      unless not person.email.nil?
        person.email = f["mail"]
      end
      unless not person.phone.nil?
        person.phone = f["telephoneNumber"]
      end
      unless not person.address.nil?
        person.address = f["street"]
      end
    
      # Add them to their ou group, creating it if necessary
      if(f["ou"].length == 0)
        f["ou"] = "Unnamed"
      end
    
      if( f["ucdPersonAffiliation"] == "student:graduate" )
        # Graduate student 'ou's are determined not by the ou entry but by the 
        ou = Ou.find(:first, :conditions => [ "lower(name) = ?", f["ucdStudentMajor"].downcase ]) || Ou.create(:name => f["ucdStudentMajor"])
        # The dept code & manager won't be set here but should get updated once a faculty/staff comes along for that dept
        ou.save
      else
        # Not a graduate student: f["ou"] entry is reliable
        ou = Ou.find(:first, :conditions => [ "lower(name) = ?", f["ou"].downcase ]) || Ou.create(:name => f["ou"])
        # Assume dept codes match name strings
        ou.code = f["dept_code"]
      
        unless UcdLookups::DEPT_CODES[f["dept_code"]].nil?
          manager = Person.find_by_loginid(UcdLookups::DEPT_CODES[f["dept_code"]]["manager"]) || Person.create(:loginid => UcdLookups::DEPT_CODES[f["dept_code"]]["manager"])
          # Avoid duplicate managers
          unless ou.managers.exists? manager
            ou.managers << manager
          end
        else
          # Dept code doesn't exist
          puts "Could not find a dept_code for " + f["dept_code"]
        end
      
        ou.save
      end
    
      person.ous << ou
    
      if(f["title"].length == 0)
        f["title"] = "Unnamed"
      end
    
      # Add to group based on title, creating it if necessary
      group = Group.find(:first, :conditions => [ "lower(name) = ?", f["title"].downcase ]) || Group.create(:name => f["title"])
      group.save
      person.groups << group
    
      # Assign their affiliation, creating it if necessary (affiliations are a 1:n relationship)
      #affiliation = Affiliation.find(:first, :conditions => [ "lower(name) = ?", f["ucdPersonAffiliation"].downcase ]) || Affiliation.create(:name => f["ucdPersonAffiliation"])
      #person.affiliation = affiliation
    
      person.status = true
      person.preferred_name = "#{person.first} #{person.last}"
    
      if person.valid? == false
        puts "Unable to save individual:"
        pp person
      else
        person.save
      end
    end
  
  end
  
  desc 'Erases any data that might be introduced by LDAP. Be very careful and back up your database!'
  task :erase => :environment do
    if Rails.env != "production"
      Person.destroy_all
      Group.destroy_all
      Ou.destroy_all
    end
  end
end
