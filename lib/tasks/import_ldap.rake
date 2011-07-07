desc 'Runs the LDAP import. Takes approx. 10-15 mins.'
task :import_ldap => :environment do
  require 'ldap'

  # Include the large lot of UCD info (dept codes, title codes, etc.)
  load 'UcdLookups.rb'

  # Set up some manual data - would go in UcdLookups.rb but UcdLookups is auto-generated w/o this info
  basePeople = 'ou=People,dc=ucdavis,dc=edu'
  manualIncludes=['jeremy','aeguyer','millerlm','djmoglen','mebalvin','mckinney','ssantam','tmheath','rnanakul','olichney','sukkim','jpokorny','bgrunewa','rabronst','kbaynes','szneena','pcmundy','wjarrold','julieluu','steichho','chuff','cmachado','alamsyah','schuang','clare186','ladyd252','aheusser','pkubitz','kshap','bbrelles','blmiss','pjdegenn','cdaniels','jyiwang','anschnei','eaisham','ralatif','cwbishop','fddiaz']
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

        people << person
      end
  end
  
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

  # Add people to database
  for f in finalPeople
    person = Person.new
    puts f
    person.loginid = f["principal_name"].slice(0, f["principal_name"].index("@"))
    person.first = f["givenName"]
    person.last = f["sn"]
    person.email = f["mail"]
    person.phone = f["telephoneNumber"]
    person.address = f["street"]
    
    # Add them to their ou group, creating it if necessary
    if(f["ou"].length > 0)
      f["ou"] = "Unnamed"
    end
    group = Group.find_by_name(f["ou"])
    if(group == nil)
      # Doesn't exist, create it
      group = Group.new
      group.name = f["ou"]
      # Assume dept codes match name strings
      group.code = f["dept_code"]
      group.save
    end
    
    person.groups << group
    
    # Assign their title, creating it if necessary (titles are a 1:n relationship)
    title = Title.find_by_name(f["title"])
    if(title == nil)
      # Doesn't exist, create it
      title = Title.new
      title.name = f["title"]
      # Assume title codes match title strings
      title.code = f["title_code"]
      title.save
    end
    person.title = title
    
    # Assign their affiliation, creating it if necessary (affiliations are a 1:n relationship)
    affiliation = Affiliation.find_by_name(f["ucdPersonAffiliation"])
    if(affiliation == nil)
      # Doesn't exist, create it
      affiliation = Affiliation.new
      affiliation.name = f["ucdPersonAffiliation"]
      affiliation.save
    end
    person.affiliation = affiliation
    
    person.status = true
    person.preferred_name = "#{person.first} #{person.last}"
    
    person.save
  end
  
end
