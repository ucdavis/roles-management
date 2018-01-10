require 'roles-management-api'

class ActiveDirectoryHelper
  # Adds the SENTINEL_DESCRIPTOR text to an AD group's description field if
  # it is not present.
  #
  # +group+ is a Net::LDAP::Entry object or a string
  # +application_name+ is an optional string of the application's name, if applicable
  # +role_name+ is an optional string of the role's name, if applicable
  # @return true if description was present or added successfully to +group+
  def ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(group, application_name = nil, role_name = nil)
    unless group.is_a? Net::LDAP::Entry
      group = ActiveDirectory.get_group(group)
      if group.nil?
        STDERR.puts 'ensure_sentinel_descriptor_presence failed: Cannot get_group().'
        return false
      end
    end

    g_desc = group[:description][0]
    g_desc = '' if g_desc.nil?

    if(application_name && role_name)
      sentinel_txt = "(RM Sync: #{application_name} / #{role_name})"
    else
      sentinel_txt = '(RM Sync: Universal)'
    end

    # Remove the old-style sentinel if it exists
    if g_desc.index '(RM Sync)'
      g_desc.slice! '(RM Sync)'
      g_desc.lstrip!
    end

    # Update sentinel only if it doesn't already exist
    unless g_desc.index sentinel_txt
      STDOUT.puts "Adding '#{sentinel_txt}' to AD group description."
      g_desc = "#{sentinel_txt} #{g_desc}"
      return ActiveDirectory.update_group_description(group, g_desc)
    end

    # Sentinel already existed
    return true
  end

  # Removes the SENTINEL_DESCRIPTOR text from an AD group's description field if
  # it is present.
  #
  # +group+ is a Net::LDAP::Entry object or a string
  # @return true if description was not present or removed successfully to +group+
  def ActiveDirectoryHelper.ensure_sentinel_descriptor_absence(group)
    unless group.is_a? Net::LDAP::Entry
      group = ActiveDirectory.get_group(group)
    end

    if group.nil?
      STDERR.puts 'ensure_sentinel_descriptor_absence failed: Cannot get_group().'
      return false
    end

    g_desc = group[:description][0]
    unless g_desc
      STDERR.puts 'ensure_sentinel_descriptor_absence failed: g_desc is nil.'
      return false
    end

    matches = /\(RM Sync[\s\S]*\)/.match(g_desc)

    if matches != nil
      STDOUT.puts "Removing '#{matches.to_s}' from AD group description."
      g_desc.sub! /\(RM Sync[\s\S]*\)/, ''
      g_desc.lstrip!
      return ActiveDirectory.update_group_description(group, g_desc)
    end

    return false
  end

  # +user+ may be a loginid (string) or Net::LDAP::Entry object
  # +group+ may be an AD path (string) or Net::LDAP::Entry object
  # +ad_guid+ may be provided (optional) and will be preferred over AD Path if
  # +group+ is a string (AD Path)
  def ActiveDirectoryHelper.ensure_user_in_group(user, group, ad_guid = nil)
    unless user.is_a? Net::LDAP::Entry
      user = ActiveDirectory.get_user(user)
      if user.nil?
        STDERR.puts "ensure_user_in_group failed: user is nil."
        return false
      end
    end
    unless group.is_a? Net::LDAP::Entry
      group = ActiveDirectory.get_group(group)
      if group.nil?
        STDERR.puts "ensure_user_in_group failed: group is nil."
        return false
      end
    end

    # returns true or false
    ActiveDirectory.add_user_to_group(user, group)
  end

  # User may be a loginid (string) or Net::LDAP::Entry object
  # Group may be an AD path (string) or Net::LDAP::Entry object
  # ad_guid may be provided (optional) and will be prefered over AD Path if
  # 'group' is a string (AD Path)
  def ActiveDirectoryHelper.ensure_user_not_in_group(user, group, ad_guid = nil)
    unless user.is_a? Net::LDAP::Entry
      user = ActiveDirectory.get_user(user)
      if user.nil?
        STDERR.puts "ensure_user_not_in_group failed: user is nil."
        return false
      end
    end
    unless group.is_a? Net::LDAP::Entry
      group = ActiveDirectory.get_group(group)
      if group.nil?
        STDERR.puts "ensure_user_not_in_group failed: group is nil."
        return false
      end
    end

    # returns true or false
    ActiveDirectory.remove_user_from_group(user, group)
  end

  # Retrieves all members from both the role in RM and the AD group and ensures
  # both have the same members by adding any missing members from one to the other
  # (inclusively).
  def ActiveDirectoryHelper.merge_role_and_ad_group(role_id, group_name, rm_client)
    ad_group = ActiveDirectory.get_group(group_name)

    unless ad_group.is_a? Net::LDAP::Entry
      abort("Could not retrieve AD group '#{group_name}'")
    end

    role = rm_client.find_role_by_id(role_id)

    # Add any role members to the AD group
    role.members.each do |member|
      STDOUT.puts "Ensuring #{member.loginid} is in AD group #{group_name} ..."
      ActiveDirectoryHelper.ensure_user_in_group(member.loginid, ad_group)
    end

    # Simple flag to avoid unnecessary RM activity
    role_changed = false

    # Add any AD group members to the role
    ActiveDirectory.list_group_members(ad_group).each do |ad_member|
      p = rm_client.find_person_by_loginid(ad_member)
      if p
        STDOUT.puts "Ensuring #{p.loginid} is in RM role #{role} ..."
        unless role.members.map(&:loginid).include? p.loginid
          role.assignments << p
          role_changed = true
        end
      else
        STDERR.puts "RM could not find AD member #{ad_member}. Unable to copy back into role."
      end
    end

    rm_client.save(role) if role_changed
  end

  # Converts common organization names to their AD-mapped equivalents
  # Returns a match, nil (if we know the organization but do not wish to sync it), or
  # false (if we do not know the organization and need to log this missing data).
  def ActiveDirectoryHelper.ou_to_short(name)
    name = name.upcase

    case name
    when "DSS IT SERVICE CENTER", "DSS IT SHARED SERVICE CENTER"
      return "IT"
    when "DSS HR/PAYROLL SERVICE CENTER"
      return "HR"
    when "CALIFORNIA HISTORY SS PROJECT"
      return "CHP"
    when "UC CENTER SACRAMENTO"
      return "UCCS"
    when "HEMISPHERIC INSTITUTE-AMERICAS"
      return "PHE"
    when "HISTORY PROJECT", "HISTORY PROJECT UCD"
      return "HP"
    when "SOCIAL SCIENCES PROGRAM"
      return "SSP"
    when "PHYSICAL EDUCATION PROGRAM"
      return "PHE"
    when "DSS RESEARCH SERVICE CENTER"
      return "RSC"
    when "GEOGRAPHY"
      return "GEO"
    when "ANTHROPOLOGY"
      return "ANT"
    when "COMMUNICATION"
      return "CMN"
    when "ECONOMICS"
      return "ECN"
    when "HISTORY"
      return "HIS"
    when "LINGUISTICS"
      return "LIN"
    when "MILITARY SCIENCE"
      return "MSC"
    when "PHILOSOPHY"
      return "PHI"
    when "POLITICAL SCIENCE"
      return "POL"
    when "PSYCHOLOGY"
      return "PSC"
    when "EASTERN ASIAN STUDIES"
      return "EAS"
    when "INTERNATIONAL RELATIONS"
      return "IRE"
    when "MIDDLE EAST/SOUTH ASIA STUDIES", "MIDDLE EAST/SOUTH ASIA PROGRAM"
      return "MSA"
    when "SCIENCE & TECHNOLOGY STUDIES"
      return "STS"
    when "CENTER FOR MIND AND BRAIN", "CENTER FOR MIND & BRAIN"
      return "CMB"
    when "SOCIOLOGY"
      return "SOC"
    when "COM, PHIL & LIN RED CLUSTER"
      return "RED"
    when "POLI SCI, IR ORANGE CLUSTER", "SOCIAL SCIENCE ORANGE CLUSTER"
      return "ORANGE"
    when "ECON, HIS, MS BLUE CLUSTER", "SOCIAL SCIENCES BLUE CLUSTER"
      return "BLUE"
    when "ANT, SOC GREEN CLUSTER", "SOCIAL SCIENCES GREEN CLUSTER"
      return "GREEN"
    when "L&S DEANS - SOCIAL SCIENCES"
      return "DEANS"
    when "PSYCH, CMB YELLOW CLUSTER", "SOCIAL SCIENCE YELLOW CLUSTER"
      return "YELLOW"
    when "EDUCATION - PH.D."
      return "EDU"
    when "COMMUNITY DEVELOPMENT"
      return "ComDev"
    when "NEUROSCIENCE", "CENTER FOR NEUROSCIENCE"
      return "NueroSci"
    when "CENTER FOR INNOVATION STUDIES"
      return "CSIS"
    when "ASUCD", "UC DAVIS", "ASIAN AMERICAN", "UNIVERSITY EXTENSION", "CHEDDAR", "STUDENT EMPLOYMENT CENTER",
      "TEMPORARY EMPLOYMENT SERVICE", "CAMPUS RECREATION AND UNIONS", "CRESS DEPARTMENT", "LIBRARY", "POLICE",
      "COMPARATIVE LITERATURE", "PRIMATE CENTER", "L&S DEANS - U/G ED & ADVISING", "STATISTICS",
      "AGR & ENV SCI DEANS OFFICE", "OFFICE OF THE CHANCELLOR", "UNDERGRADUATE ADMISSIONS",
      "UNIVERSITY WRITING PROGRAM", "TEXTILES & CLOTHING", "STUDENT HOUSING", "ENGLISH", "ANIMAL SCIENCE",
      "IRB ADMINISTRATION", "SCHOOL OF LAW-DEANS OFFICE", "STUDENT ACADEMIC SUCCESS CTR", "GERMAN & RUSSIAN",
      "INTERCOLLEGIATE ATHLETICS", "HUMAN ECOLOGY", "GRADUATE DIVISION", "MED: NEUROLOGY",
      "ENVIRONMENTAL TOXICOLOGY", "SCHOOL OF MED - STAFF", "L&S DEANS - DEVELOPMENT",
      "TEMPORARY EMPLOYMENT POOL ADMN", "SCHOOL OF MED - APS", "MED: GENERAL PEDIATRICS",
      "MED:PSYCHIATRY & BEHAV SCI", "NATIVE AMERICAN STUDIES", "ART", "VP UNDERGRADUATE EDUCATION", "GEOLOGY",
      "VM: CTR COMPARATIVE MEDICINE", "ENGR COMPUTER SCIENCE", "MED: DIV OF INTERNAL MED",
      "FM: CUSTODIAL SERVICES", "VOORHIES ADMINISTRATIVE UNIT", "MED: OPHTHALMOLOGY", "MED: PUBLIC HEALTH SCIENCES",
      "NEURO PHYSIO & BEHAVIOR", "INST OF TRANSPORTATION STUDIES", "ENVIRONMENTAL HEALTH & SAFETY",
      "MEDIEVAL STUDIES", "EDUCATION", "ACADEMIC AFFAIRS", "ANR SUSTAINABLE AG PROG"
      return nil
    else
      STDERR.puts "AD Sync: Missing OU for translation to container name: #{name}"
    end

    return false
  end

  # Converts common affiliations to their AD-mapped equivalents
  # Returns a match, nil (if we know the affiliation but do not wish to sync it), or
  # false (if we do not know the affiliation and need to log this missing data).
  def ActiveDirectoryHelper.flatten_affiliation(affiliation)
    case affiliation
    when "faculty:senate"
      return "faculty"
    when "faculty:federation"
      return "lecturer"
    when "staff"
      return "staff"
    when "staff:career"
      return "staff"
    when "staff:casual"
      return "staff"
    when "staff:contract"
      return "staff"
    when "staff:student"
      return "staff-student"
    when "student:graduate"
      return "student-graduate"
    when "visitor:student:graduate"
      return "student-graduate"
    when "faculty"
      return "faculty"
    when "student:undergraduate", "student:law", "visitor:consultant", "student:medicine",
      "visitor:student:concurrent", "visitor:lecturer", "visitor:faculty:research", "visitor:staff:temporary",
      "visitor:postdoc:research", "visitor:faculty:teaching", "visitor:student", "student:vetmed", "student",
      "visitor", "visitor:student:extension", "external", "visitor:contractor", "visitor:vendor", "visitor:public-service-partner",
      "visitor:volunteer"
      return nil
    else
      STDERR.puts "AD Sync: Missing affiliation for translation to container name: #{affiliation}"
    end

    return false
  end
end
