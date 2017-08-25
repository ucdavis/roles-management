module LdapPersonHelper
  def self.create_or_update_person_by_loginid(loginid, log = nil)
    return nil unless loginid

    person = nil

    # Simple mock for testing api/v1/people_controller
    if Rails.env.test?
      person = Person.new
      person.loginid = loginid
      person.save!
      return person
    end

    require 'ldap_helper'

    import_start = Time.now

    ldap_import_start = Time.now

    ldap = LdapHelper.new
    ldap.connect

    results = ldap.search('(uid=' + loginid + ')')

    if !results.empty?
      person = LdapPersonHelper.create_or_update_person_from_ldap_record(results[0], log)
    else
      log.error "Could not import person #{loginid}, no results from LDAP or error while saving."

      return false
    end

    ldap_import_finish = Time.now

    person.save!

    import_finish = Time.now

    log.info "Finished LDAP import request. LDAP operation took #{ldap_import_finish - ldap_import_start}s while the entire operation took #{import_finish - import_start}s."

    return person
  end

  # Processes ldap_record and returns an un-saved person object,
  # whether loaded from the database or new.
  # May create titles, OUs, along the way (and save them).
  # Optionally pass log.
  #   We provide this as the LDAP import task generates a special log for e-mailing, else
  #   Rails.logger would suffice.
  def self.create_or_update_person_from_ldap_record(entry, log = nil)
    # Include the large lot of UCD info (dept codes, title codes, etc.)
    require 'ucd_lookups'

    # We need 'p' outside the scope of log.tagged later
    p = nil

    ActiveRecord::Base.transaction do
      loginid = determine_loginid(entry, log)

      unless loginid
        log.debug 'Ignoring LDAP entry with no eduPersonPrincipalName and no uid. ucdPersonUUID: ' + entry[:ucdPersonUUID][0].to_s unless log.nil?
        return nil
      end

      log.tagged loginid do
        log.debug "Processing LDAP record for #{loginid}" unless log.nil?
        log.debug "LDAP record data: #{entry.inspect}" unless log.nil?

        # Find or create the Person object
        p = Person.find_or_create_by( loginid: loginid )

        if p.new_record?
          log.debug "Creating new person record (#{loginid} is not already in our database)." if log
        else
          log.debug "Updating existing person record (#{loginid} is in our database)." if log

          unless p.active
            # We're re-activating a person, and certain LDAP actions such as adding a user to a group may trigger operations (AD sync) which rely on an up-to-date p.active flag.
            log.info "Existent LDAP result '#{p.loginid}' is inactive in our system. Re-activating ..."
            ActivityLog.info!("Activating #{p.name} as they are in LDAP.", ["person_#{p.id}", 'ldap'])
            p.active = true
            p.save
          end
        end

        p = determine_basic_details(p, entry, log)
        p = determine_affiliation_details(p, entry, log)
        p = determine_title_details(p, entry, log)
        p = determine_student_data(p, entry, log)
        p = determine_ou_memberships(p, entry, log)

        save_or_touch(p, log) if p
      end
    end

    ou = nil
    company = nil
    ou_manager = nil

    return p
  end

  # Resolves loginid based on eduPersonPrincipalName (preferred) or uid
  def self.determine_loginid(entry, log = nil)
    # First, determine their login ID from the principal name
    eduPersonPrincipalName = entry[:eduPersonPrincipalName][0]
    if eduPersonPrincipalName.nil?
      # If they don't have an eduPersonPrincipalName, we'll take the uid, else we'll just log this entry and skip it
      unless entry[:uid][0].nil?
        loginid = entry[:uid][0]
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
  def self.determine_basic_details(p, entry, log = nil)
    p.first = entry[:givenName][0]
    p.last = entry[:sn][0]
    p.email = entry[:mail][0]

    if p.email and p.email.include? "ucdmc.ucdavis.edu"
      # Override ucdmc.ucdavis.edu e-mails.
      # p.loginid + "@ucdavis.edu" is not always their e-mail address
      # but it will be routed correctly by UCD's SMTP server
      p.email = p.loginid + "@ucdavis.edu"
    end

    p.phone = entry[:telephoneNumber][0]
    unless p.phone.nil?
      # Clean up number
      p.phone = p.phone.sub("+1 ", "").gsub(" ", "")
    end
    p.address = entry[:street][0]
    p.name = entry[:displayName][0]

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
  def self.determine_student_data(p, entry, log = nil)
    # Handle student-specific data
    ucd_student_major = entry[:ucdStudentMajor][0]
    ucd_student_level = entry[:ucdStudentLevel][0]

    # If they have any student data, ensure they own a corresponding 'student' model
    if ucd_student_major || ucd_student_level
      byebug
      p.student = Student.new if p.student.nil?
    end

    # Update the list of majors if needed and record the major if needed
    unless ucd_student_major.nil?
      major = Major.find_or_create_by(name: ucd_student_major)
      p.major = major
    end

    # Update the list of student levels if needed and record the student level if needed
    unless ucd_student_level.nil?
      level = StudentLevel.find_or_create_by(name: ucd_student_level)
      p.student.level = level
    end

    return p
  end

  # Resolve affiliation detail from ucdPersonAffiliation
  def self.determine_affiliation_details(p, entry, log = nil)
    seen_affiliations = []

    # A person may have multiple affiliations
    entry[:ucdPersonAffiliation].each do |affiliation_name|
      seen_affiliations << affiliation_name
      affiliation = Affiliation.find_or_create_by( name: affiliation_name )
      unless p.affiliations.include?(affiliation)
        p.affiliations << affiliation
      end
    end

    # Remove any affiliations from the person not mentioned by LDAP
    p.affiliations.each do |affiliation|
      p.affiliations.destroy(affiliation) unless seen_affiliations.include?(affiliation.name)
    end

    return p
  end

  # Resolve title details from ucdAppointmentTitleCode.
  # Note that the 'title' attribute in LDAP can be user-edited and
  # should not be considered reliable.
  def self.determine_title_details(p, entry, log = nil)
    # Set title: take the original unless there is a translation from UcdLookups
    title_code = entry[:ucdAppointmentTitleCode][0]
    title_code = title_code.rjust(4, '0') unless title_code.blank?

    # Only update the person if a title code was found in LDAP
    unless title_code.blank?
      title = Title.find_or_create_by( code: title_code )
      if title.name.blank?
        log.warn "Title code #{title_code} has no name (title ID ##{title.id}). Ensure title database is up-to-date."
      end

      p.title = title
    end

    return p
  end

  # Creates and assigns OUs as needed based on
  def self.determine_ou_memberships(p, entry, log = nil)
    ucdStudentMajor = entry[:ucdStudentMajor][0]
    ucdStudentLevel = entry[:ucdStudentLevel][0]

    # Prefer UcdLookups for OU, company, and manager information if available
    ucdAppointmentDepartmentCode = entry[:ucdAppointmentDepartmentCode][0]

    majorDept, ou_name, ou_manager_name, company_code, company_name, company_manager_name = resolve_ou_relationship(ucdAppointmentDepartmentCode, ucdStudentMajor)

    # Log if this individual has neither piece of needed information to assign them to an Organization
    if (ucdAppointmentDepartmentCode == nil) && (ucdStudentMajor == nil)
      log.warn "Individual (#{p.loginid}) has neither a ucdAppointmentDepartmentCode nor a ucdStudentMajor. FIXME" unless log.nil?
      return p
    end

    # OU treatment varies for graduate students vs everybody else
    if p.affiliations.collect{ |x| x.name }.include?("student:graduate") and ucdStudentMajor
      # Graduate student
      # make sure they're in the ucdAppointmentDepartmentCode, ucdStudentMajor
      ou = Organization.where('lower(name) = ?', ucdStudentMajor.downcase).first
      # The dept code & manager won't be set here but should get updated once a faculty/staff comes along for that dept
    elsif p.affiliations.collect{ |x| x.name }.include?("student:undergraduate") and ucdStudentMajor and not ucdAppointmentDepartmentCode
      # Undergraduate with no employment
      ou = Organization.where('lower(name) = ?', ucdStudentMajor.downcase).first
      # The dept code & manager won't be set here but should get updated once a faculty/staff comes along for that dept
    else
      # Neither an undergraduate student nor a graduate student
      # Likely staff or faculty

      ou = Organization.find_by_dept_code(ucdAppointmentDepartmentCode)
      ou = Organization.where('lower(name) = ?', ou_name.downcase).first if ou.nil? and ou_name

      if ou
        # Set OU manager to be an owner of their OU
        ou_manager = Person.find_or_create_by( loginid: ou_manager_name ) unless ou_manager_name.blank?

        if ou_manager
          # Ensure this manager is recorded for the Organization
          unless ou.managers.include? ou_manager
            log.debug "Assigning Person with login ID '#{ou_manager_name}' as a manager of Organization '#{ou.name}'" unless log.nil?
            ActivityLog.info!("Assigning Person with login ID '#{ou_manager_name}' as a manager of Organization '#{ou.name}'.", ["person_#{ou_manager.id}", "organization_#{ou.id}", 'ldap'])
            ou.managers << ou_manager
          end

          # Ensure they have this person as their favorite
          unless (ou_manager.id == p.id) or (ou_manager.favorites.include? p)
            # Ensure a manager has all their employees automatically set as favorites
            # keep adding them as favorites
            log.debug "Adding favorite of '#{p.loginid}' to Organization manager '#{ou_manager_name}' (manager of Organization '#{ou.name}')" unless log.nil?
            ActivityLog.info!("Adding favorite of '#{p.loginid}' to Organization manager '#{ou_manager_name}' (manager of Organization '#{ou.name}').", ["person_#{ou_manager.id}", 'ldap'])
            ou_manager.favorites << p
          end
        end
      else
        log.warn "Unable to assign an Organization for person #{p.loginid}. ucdAppointmentDepartmentCode: '#{ucdAppointmentDepartmentCode}', ucdStudentMajor is '#{ucdStudentMajor}', ou_name resolved to '#{ou_name}'. FIXME" unless log.nil?
      end
    end

    unless p.organizations.include?(ou) or ou.nil?
      log.debug "Adding person '#{p.loginid}' to Organization '#{ou.name}'." unless log.nil?
      ActivityLog.info!("Adding person '#{p.loginid}' to Organization '#{ou.name}'.", ["person_#{p.id}", "organization_#{ou.id}", 'ldap'])
      p.organizations << ou
    end

    # Remove this person from any OUs not mentioned in LDAP
    # in case they have since left that department/company.
    # Note: It's assumed LDAP can only mention up to one OU
    #       We do not simply remove all OUs and then re-add
    #       the proper one above in order to maintain clean
    #       logs (deleting an OU association may trigger a
    #       log message).
    p.organizations.each do |o|
      if (o != ou)
        p.organizations.destroy(o)
        log.debug "Removing person '#{p.loginid}' from Organization '#{o.name}'" unless log.nil?
        ActivityLog.info!("Removing person '#{p.loginid}' from Organization '#{o.name}'.", ["person_#{p.id}", "organization_#{o.id}", 'ldap'])
      end
    end

    return p
  end

  # Simple function to determine _how_ a person is related to UCD (staff, faculty, student) and return
  # the relevant OU details. This is separate from determine_affiliation_details.
  def self.resolve_ou_relationship(ucdAppointmentDepartmentCode, ucdStudentMajor)
    if ucdAppointmentDepartmentCode
      if UcdLookups::DEPT_CODES.keys().include? ucdAppointmentDepartmentCode
        # This OU should be in the org tree
        majorDept = nil
        ou_name = UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]['name']
        ou_manager_name = UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]['manager']
        company_code = UcdLookups::DEPT_CODES[ucdAppointmentDepartmentCode]['company']
        company_name = UcdLookups::DEPT_CODES[company_code]['name']
        company_manager_name = UcdLookups::DEPT_CODES[company_code]['manager']
      elsif ucdStudentMajor
        # Use major to determine OU (should still be in the org tree)
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
      # Log if the major is not in the lookup table and add them
      if UcdLookups::MAJORS.keys().include? ucdStudentMajor
        majorDept = UcdLookups::MAJORS[ucdStudentMajor]
        ou_name = UcdLookups::DEPT_CODES[majorDept]['name']
        ou_manager_name = UcdLookups::DEPT_CODES[majorDept]['manager']
        company_code = UcdLookups::DEPT_CODES[majorDept]['company']
        company_name = UcdLookups::DEPT_CODES[company_code]['name']
        company_manager_name = UcdLookups::DEPT_CODES[company_code]['manager']
      end
    end

    return majorDept, ou_name, ou_manager_name, company_code, company_name, company_manager_name
  end

  def self.save_or_touch(p, log)
    if p.valid? == false
      log.warn "Unable to create or update persion with loginid #{p.loginid}. Reason(s): "
      p.errors.messages.each do |field,reason|
        log.warn "\tField #{field} #{reason}"
      end
    else
      # Person is valid.
      if p.changed? == false
        log.debug "No standard record changes for #{p.loginid}"
      else
        log.debug "Updating the following for #{p.loginid}:"
        p.changes.each do |field,changes|
          log.debug "\t#{field}: '#{changes[0]}' -> '#{changes[1]}'"
          ActivityLog.info!("Attribute update: '#{field}': '#{changes[0]}' -> '#{changes[1]}'", ["person_#{p.id}", 'ldap'])
        end

        p.save!
      end

      if p.student
        if p.student.changed? == false
          log.debug "Student record exists but there are no changes for #{p.loginid}"
        else
          log.debug "Updating the following student records for #{p.loginid}:"
          p.student.changes.each do |field,changes|
            log.debug "\t#{field}: '#{changes[0]}' -> '#{changes[1]}'"
            ActivityLog.info!("Attribute update: '#{field}': '#{changes[0]}' -> '#{changes[1]}'", ["person_#{p.id}", 'ldap'])
          end

          p.student.save!
        end
      end
    end
  end
end
