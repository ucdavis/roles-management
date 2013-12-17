module LdapPersonHelper
  # Processes ldap_record and returns an un-saved person object,
  # whether loaded from the database or new.
  # May create titles, OUs, along the way (and save them).
  # Optionally pass log.
  #   We provide this as the LDAP import task generates a special log for e-mailing, else
  #   Rails.logger would suffice.
  def LdapPersonHelper.create_or_update_person_from_ldap(entry, log = nil)
    # Include the large lot of UCD info (dept codes, title codes, etc.)
    require 'ucd_lookups'
    
    loginid = determine_loginid(entry, log)
    
    unless loginid
      log.debug "Ignoring LDAP entry with no eduPersonPrincipalName and no uid. ucdPersonUUID: " + entry.get_values('ucdPersonUUID').to_s unless log.nil?
      return nil
    end
    
    # We need 'p' outside the scope of log.tagged later
    p = nil
    
    log.tagged loginid do
      log.debug "Processing LDAP record for #{loginid}" unless log.nil?
      
      # Find or create the Person object
      p = Person.find_or_initialize_by_loginid(loginid)
      
      if p.new_record?
        log.debug "Creating new person record (#{loginid} is not already in our database)." if log
      else
        log.debug "Updating existing person record (#{loginid} is in our database)." if log
      end
      
      p = determine_basic_details(p, entry, log)
      p = determine_affiliation_details(p, entry, log)
      p = determine_title_details(p, entry, log)
      p = determine_student_data(p, entry, log)
      p = determine_ou_memberships(p, entry, log)
    end
    
    ou = nil
    company = nil
    ou_manager = nil

    return p
  end
  
  # Resolves loginid based on eduPersonPrincipalName (preferred) or uid
  def LdapPersonHelper.determine_loginid(entry, log = nil)
    # First, determine their login ID from the principal name
    eduPersonPrincipalName = entry.get_values('eduPersonPrincipalName').to_s[2..-3]
    if eduPersonPrincipalName.nil?
      # If they don't have an eduPersonPrincipalName, we'll take the uid, else we'll just log this entry and skip it
      unless entry.get_values('uid').to_s[2..-3].nil?
        loginid = entry.get_values('uid').to_s[2..-3]
      else
        # Give up
        return nil
      end
    else
      loginid = eduPersonPrincipalName.slice(0, eduPersonPrincipalName.index("@"))
    end
    
    return loginid
  end
  
  # Resolve basic details like first and last name, email, i.e. simple values which do not require relations.
  def LdapPersonHelper.determine_basic_details(p, entry, log = nil)
    p.first = entry.get_values('givenName')[0]
    p.last = entry.get_values('sn')[0]
    p.email = entry.get_values('mail').to_s[2..-3]
    p.phone = entry.get_values('telephoneNumber').to_s[2..-3]
    unless p.phone.nil?
      # Clean up number
      p.phone = p.phone.sub("+1 ", "").gsub(" ", "")
    end
    p.address = entry.get_values('street').to_s[2..-3]
    p.name = entry.get_values('displayName')[0]
    
    # If no displayName exists, construct one from p.first and p.last
    if p.name.nil? and p.first and p.last
      p.name = p.first + ' ' + p.last
    elsif p.name.nil?
      # No first or last either? Use loginid
      p.name = p.loginid
    end
    
    return p
  end
  
  # Resolve student data e.g. ucdStudentMajor, ucdStudentLevel (if applicable)
  def LdapPersonHelper.determine_student_data(p, entry, log = nil)
    # Handle student-specific data
    ucdStudentMajor = entry.get_values('ucdStudentMajor').to_s[2..-3]
    ucdStudentLevel = entry.get_values('ucdStudentLevel').to_s[2..-3]

    # If they have any student data, ensure they own a corresponding 'student' model
    if ucdStudentMajor or ucdStudentLevel
      p.student = Student.new if p.student == nil
    end
    
    # Update the list of majors if needed and record the major if needed
    unless ucdStudentMajor.nil?
      major = Major.find_or_create_by_name ucdStudentMajor
      p.major = major
    end
    
    # Update the list of student levels if needed and record the student level if needed
    unless ucdStudentLevel.nil?
      level = StudentLevel.find_or_create_by_name ucdStudentLevel
      p.student.level = level
    end
    
    return p
  end
  
  # Resolve affiliation detail from ucdPersonAffiliation
  def LdapPersonHelper.determine_affiliation_details(p, entry, log = nil)
    # A person may have multiple affiliations
    entry.get_values('ucdPersonAffiliation').each do |affiliation_name|
      affiliation = Affiliation.find_or_create_by_name(affiliation_name)
      unless p.affiliations.include? affiliation
        p.affiliations << affiliation
      end
    end
    
    return p
  end
  
  # Resolve title details from ucdAppointmentTitleCode
  def LdapPersonHelper.determine_title_details(p, entry, log = nil)
    # Set title: take the original unless there is a translation from UcdLookups
    title_name = entry.get_values('title').to_s[2..-3]
    ucdAppointmentTitleCode = entry.get_values('ucdAppointmentTitleCode').to_s[2..-3]
    
    if UcdLookups::TITLE_CODES[ucdAppointmentTitleCode]
      title_name = UcdLookups::TITLE_CODES[ucdAppointmentTitleCode]['title']
    end
    
    unless title_name.blank?
      title = Title.find_or_create_by_name(title_name)
    
      # Update the title code information, if necessary
      if title.code.nil?
        title.code = ucdAppointmentTitleCode
        title.save
      end

      p.title = title
    end
    
    return p
  end
  
  # Creates and assigns OUs as needed based on 
  def LdapPersonHelper.determine_ou_memberships(p, entry, log = nil)
    ucdStudentMajor = entry.get_values('ucdStudentMajor').to_s[2..-3]
    ucdStudentLevel = entry.get_values('ucdStudentLevel').to_s[2..-3]
    
    # Prefer UcdLookups for OU, company, and manager information if available
    ucdAppointmentDepartmentCode = entry.get_values('ucdAppointmentDepartmentCode').to_s[2..-3]
    if ucdAppointmentDepartmentCode
      if UcdLookups::DEPT_CODES.keys().include? ucdAppointmentDepartmentCode
        ou_name = UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]['name']
        ou_manager_name = UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]['manager']
        company_code = UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]['company']
        company_name = UcdLookups::DEPT_CODES[company_code]['name']
        company_manager_name = UcdLookups::DEPT_CODES[company_code]['manager']
      elsif ucdStudentMajor
        if UcdLookups::MAJORS.keys().include? ucdStudentMajor
          majorDept = UcdLookups::MAJORS[ucdStudentMajor]
          ou_name = UcdLookups::DEPT_CODES[majorDept]['name']
          ou_manager_name = UcdLookups::DEPT_CODES[majorDept]['manager']
          company_code = UcdLookups::DEPT_CODES[majorDept]['company']
          company_name = UcdLookups::DEPT_CODES[company_code]['name']
          company_manager_name = UcdLookups::DEPT_CODES[company_code]['manager']
        end
      end
    elsif ucdStudentMajor
      if UcdLookups::MAJORS.keys().include? ucdStudentMajor
        majorDept = UcdLookups::MAJORS[ucdStudentMajor]
        ou_name = UcdLookups::DEPT_CODES[majorDept]['name']
        ou_manager_name = UcdLookups::DEPT_CODES[majorDept]['manager']
        company_code = UcdLookups::DEPT_CODES[majorDept]['company']
        company_name = UcdLookups::DEPT_CODES[company_code]['name']
        company_manager_name = UcdLookups::DEPT_CODES[company_code]['manager']
      end
    end

    # DEPT_TRANSLATIONS helps similar names (alternate spellings, etc.) into a consistent name
    if UcdLookups::DEPT_TRANSLATIONS.keys().include? ou_name
      ou_name = UcdLookups::DEPT_TRANSLATIONS[ou_name]
    end

    # OU treatment varies for graduate students vs everybody else
    if p.affiliations.collect{ |x| x.name }.include?("student:graduate") and ucdStudentMajor
      # Graduate student
      ou = Group.find(:first, :conditions => [ "lower(name) = ?", ucdStudentMajor.downcase ]) || Group.create(:name => ucdStudentMajor)
      # The dept code & manager won't be set here but should get updated once a faculty/staff comes along for that dept
      ou.save!
    elsif p.affiliations.collect{ |x| x.name }.include?("student:undergraduate") and ucdStudentMajor and not ucdAppointmentDepartmentCode
      # Undergraduate with no employment
      ou = Group.find(:first, :conditions => [ "lower(name) = ?", ucdStudentMajor.downcase ]) || Group.create(:name => ucdStudentMajor)
      # The dept code & manager won't be set here but should get updated once a faculty/staff comes along for that dept
      ou.save!
    else
      # Not a graduate student
      
      # Ensure 'ou' exists, update if necessary
      if ou_name
        ou = Group.find(:first, :conditions => [ "lower(name) = ?", ou_name.downcase ]) || Group.create(:name => ou_name)
        ou.code = ucdAppointmentDepartmentCode if ou.code.nil?
        ou.save!
        
        # Set OU manager to be an owner of their OU. Ensure this person record is in manager's favorites
        ou_manager = Person.find_or_create_by_loginid(ou_manager_name)
        
        unless ou.owners.include? ou_manager
          ou.owners << ou_manager
        end

        # Ensure they have this person as their favorite
        unless (ou_manager.id == p.id) or (ou_manager.favorites.include? p)
          # Ensure a manager has all their employees automatically set as favorites
          ou_manager.favorites << p
        end
      elsif ucdAppointmentDepartmentCode
        # Department with no translation. Assume LDAP data is trustworthy.
        ou = Group.find_or_initialize_by_code(ucdAppointmentDepartmentCode)
        ou_name = entry.get_values('ou')[0]
        
        if UcdLookups::DEPT_TRANSLATIONS.keys().include? ou_name
          ou_name = UcdLookups::DEPT_TRANSLATIONS[ou_name]
        end
        
        ou.name = ou_name
        
        ou.save!
      end

      # Ensure 'company' exists, update if necessary
      if company_name
        company = Group.find_or_initialize_by_code(company_code)
        company.name = company_name if company.name.blank?
        company.save!

        # Set company manager to be an owner of their company.
        company_manager = Person.find_or_create_by_loginid(company_manager_name)

        unless company.owners.include? company_manager
          company.owners << company_manager
        end
      end
    end

    unless p.groups.include? ou or ou.nil?
      p.groups << ou
    end
    
    unless p.groups.include? company or company.nil?
      p.groups << company
    end
    
    # Remove this person from any OUs not mentioned in LDAP
    # in case they have since left that department/company.
    # Note: It's assumed LDAP can only mention up to one OU
    #       We do not simply remove all OUs and then re-add
    #       the proper one above in order to maintain clean
    #       logs (deleting an OU association may trigger a
    #       log message).
    p.groups.ous.each do |o|
      if (o != ou) and (o != company)
        p.groups.destroy(o)
        log.debug "Removing ou #{o.name} from person #{p.loginid}" unless log.nil?
      end
    end
    
    return p
  end
end
