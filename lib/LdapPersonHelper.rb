module LdapPersonHelper
  # Processes ldap_record and returns an un-saved person object,
  # whether loaded from the database or new.
  # May create titles, OUs, along the way (and save them).
  # Optionally pass log.
  #   We provide this as the LDAP import task generates a special log for e-mailing, else
  #   Rails.logger would suffice.
  def LdapPersonHelper.create_or_update_person_from_ldap(entry, log = nil)
    # Include the large lot of UCD info (dept codes, title codes, etc.)
    load 'UcdLookups.rb'
    
    # First, determine their login ID from the principal name
    eduPersonPrincipalName = entry.get_values('eduPersonPrincipalName').to_s[2..-3]
    if eduPersonPrincipalName.nil?
      # If they don't have an eduPersonPrincipalName, we'll take the uid, else we'll just log this entry and skip it
      unless entry.get_values('uid').to_s[2..-3].nil?
        loginid = entry.get_values('uid').to_s[2..-3]
      else
        # Give up
        log.warn "Ignoring LDAP entry with no eduPersonPrincipalName and no uid. ucdPersonUUID: " + entry.get_values('ucdPersonUUID').to_s unless log.nil?
        return nil
      end
    else
      loginid = eduPersonPrincipalName.slice(0, eduPersonPrincipalName.index("@"))
    end
    
    # We need 'p' outside the scope of log.tagged later
    p = nil
    
    log.tagged loginid do
      log.info "Processing LDAP record for #{loginid}" unless log.nil?

      # Find or create the Person object
      p = Person.find_or_initialize_by_loginid(loginid)

      if log
        if p.new_record?
          log.info "Creating new person record (#{loginid} is not already in our database)."
        else
          log.info "Updating existing person record (#{loginid} is in our database)."
        end
      end

      p.first = entry.get_values('givenName')[0]
      p.last = entry.get_values('sn')[0]
      p.email = entry.get_values('mail').to_s[2..-3]
      p.phone = entry.get_values('telephoneNumber').to_s[2..-3]
      unless p.phone.nil?
        p.phone = p.phone.sub("+1 ", "").gsub(" ", "") # clean up number
      end
      p.address = entry.get_values('street').to_s[2..-3]
      p.name = entry.get_values('displayName')[0]

      if p.new_record?
        # Only turn this individual on if they're new - we don't want to override
        # a disabled individual just because we're updating their information from LDAP.
        p.status = true
      end

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

      # Use UcdLookups to clean up the data
      ucdAppointmentDepartmentCode = entry.get_values('ucdAppointmentDepartmentCode').to_s[2..-3]
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

      if(( p.affiliations.collect { |x| x.name }.include? "student:graduate" ) and not ucdStudentMajor.nil? )
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
          unless ou.owners.include? manager
            ou.owners << manager
          end

          unless (manager.id == p.id) or (manager.favorites.include? p)
            manager.favorites << p
          end
        else
          # Dept code doesn't exist
          unless ucdAppointmentDepartmentCode.nil?
            log.warn "Could not find a department code translation for " + ucdAppointmentDepartmentCode unless log.nil?
          end
        end
      end

      unless p.groups.include? ou or ou.nil?
        p.groups << ou
      end

      # Remove this person from any OUs not mentioned in LDAP
      # Note: It's assumed LDAP can only mention up to one OU
      #       We do not simply remove all OUs and then re-add
      #       the proper one above in order to maintain clean
      #       logs (deleting an OU association may trigger a
      #       log message).
      p.groups.ous.each do |o|
        if o != ou
          p.groups.destroy(o)
          log.info "Removing ou #{o.name} from person #{p.loginid}" unless log.nil?
        end
      end
    end

    return p
  end
end
