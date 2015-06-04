#! /usr/bin/env ruby

# Concerns migrating this away from the main RM program:
#   * AD Path is specific to this sync script yet needs to be in the UI
#   * GUID was found via this code and stored in RM's Role model. What now?
#   * ad_path was updated via the 'cn' property if it differed. What now?
#
# Adding per-script metadata support and optional UI would fix it but sounds
# like architecture overkill. Scripts could simply store their own RM role
# metadata if they'd like (we can promise to never change or reuse a Role ID)
# but the UI problem still remains (force AD admins to build a string from
# the token -- or simply use token for this?).

require 'json'
require 'yaml'
require 'net-ldap'
require 'roles-management-api'

class ActiveDirectory
  LDAP_ALREADY_EXISTS = 68
  LDAP_UNWILLING_TO_PERFORM = 53

  @ldap = {}

  def ActiveDirectory.configure(settings)
    @ldap[:people] = []
    @ldap[:groups] = []

    settings['people'].each do |entry|
      server = {
        :host => entry['host'],
        :base => entry['base'],
        :port => 636,
        :encryption => :simple_tls,
        :auth => {
          :method => :simple,
          :username => entry['user'],
          :password => entry['pass']
        }
      }

      conn = Net::LDAP.new(server)
      conn.bind

      @ldap[:people] << conn
    end

    settings['groups'].each do |entry|
      server = {
        :host => entry['host'],
        :base => entry['base'],
        :port => 636,
        :encryption => :simple_tls,
        :auth => {
          :method => :simple,
          :username => entry['user'],
          :password => entry['pass']
        }
      }

      conn = Net::LDAP.new(server)
      conn.bind

      @ldap[:groups] << conn
    end
  end

  def ActiveDirectory.get_user(loginid)
    @ldap[:people].each do |conn|
      result = conn.search(:filter => Net::LDAP::Filter.eq("sAMAccountName", loginid))
      raise "LDAP error while fetching user #{loginid}. Code: #{conn.get_operation_result.code }, Reason: #{conn.get_operation_result.message}" unless conn.get_operation_result.code == 0

      if result.length > 0
        return result[0]
      end
    end

    STDERR.puts "Unable to find AD user '#{loginid}'"

    return nil
  end

  def ActiveDirectory.get_group(group_name)
    @ldap[:groups].each do |conn|
      result = conn.search(:filter => Net::LDAP::Filter.eq("cn", group_name))
      raise "LDAP error while fetching group #{group_name}. Code: #{conn.get_operation_result.code }, Reason: #{conn.get_operation_result.message}" unless conn.get_operation_result.code == 0

      if result.length > 0
        return result[0]
      end
    end

    STDERR.puts "Unable to find AD group '#{group_name}'"

    return nil
  end

  def ActiveDirectory.add_user_to_group(user, group)
    unless user.is_a? Net::LDAP::Entry
      raise "Must pass valid user."
    end
    unless group.is_a? Net::LDAP::Entry
      raise "Must pass valid group."
    end

    @ldap[:groups].each do |conn|
      result = conn.modify(:dn => group[:distinguishedname][0], :operations => [
  				[ :add, :member, user[:distinguishedname][0] ]
  			])

      if conn.get_operation_result.code == LDAP_ALREADY_EXISTS
        return true # user was already in this group
      end

      raise "LDAP error while adding user (#{user[:distinguishedname][0]}) to group (#{group[:distinguishedname][0]}). Code: #{conn.get_operation_result.code }, Reason: #{conn.get_operation_result.message}" unless conn.get_operation_result.code == 0

      # result will be 'true' if user was successfully added
      return result
    end

    STDERR.puts "Unable to add user (#{user[:distinguishedname][0]}) to group (#{group[:distinguishedname][0]})"

    return false
  end

  def ActiveDirectory.remove_user_from_group(user, group)
    unless user.is_a? Net::LDAP::Entry
      raise "Must pass valid user."
    end
    unless group.is_a? Net::LDAP::Entry
      raise "Must pass valid group."
    end

    @ldap[:groups].each do |conn|
      result = conn.modify(:dn => group[:distinguishedname][0], :operations => [
				[ :delete, :member, user[:distinguishedname][0] ]
			])

      if conn.get_operation_result.code == LDAP_UNWILLING_TO_PERFORM
        return true # user was already not in the group
      end

      raise "LDAP error while removing user (#{user[:distinguishedname][0]}) from group (#{group[:distinguishedname][0]}). Code: #{conn.get_operation_result.code }, Reason: #{conn.get_operation_result.message}" unless conn.get_operation_result.code == 0

      # result will be 'true' if user was successfully removed
      return result
    end

    STDERR.puts "Unable to remove user (#{user[:distinguishedname][0]}) from group (#{group[:distinguishedname][0]})"

    return false
  end

  def ActiveDirectory.update_group_description(group, description)
    unless group.is_a? Net::LDAP::Entry
      raise "Must pass valid group."
    end

    @ldap[:groups].each do |conn|
      result = conn.modify(:dn => group[:distinguishedname][0], :operations => [
				[ :replace, 'description', description ]
			])

      raise "LDAP error while updating description for #{group[:distinguishedname][0]}. Code: #{conn.get_operation_result.code }, Reason: #{conn.get_operation_result.message}" unless conn.get_operation_result.code == 0

      # result will be 'true' if user was successfully removed
      return result
    end

    STDERR.puts "Unable to update group description (#{group[:distinguishedname][0]})"

    return false
  end

  def ActiveDirectory.list_group_members(group)
    unless group.is_a? Net::LDAP::Entry
      group = get_group(group)
    end

    if group.nil?
      STDERR.puts "Unable to list group members; group is nil."
      return nil
    end

    members = []

    group[:member].each do |member|
      members << member.match(/CN=([^,]+),/).captures[0]
    end

    return members
  end
end

# User may be a loginid (string) or Net::LDAP::Entry object
# Group may be an AD path (string) or Net::LDAP::Entry object
# ad_guid may be provided (optional) and will be prefered over AD Path if
# 'group' is a string (AD Path)
def ensure_user_in_group(user, group, ad_guid = nil)
  unless user.is_a? Net::LDAP::Entry
    user = ActiveDirectory.get_user(user)
    return false if user.nil?
  end
  unless group.is_a? Net::LDAP::Entry
    group = ActiveDirectory.get_group(group)
  end

  ensure_sentinel_descriptor_presence(group)

  ActiveDirectory.add_user_to_group(user, group)
end

# User may be a loginid (string) or Net::LDAP::Entry object
# Group may be an AD path (string) or Net::LDAP::Entry object
# ad_guid may be provided (optional) and will be prefered over AD Path if
# 'group' is a string (AD Path)
def ensure_user_not_in_group(user, group, ad_guid = nil)
  unless user.is_a? Net::LDAP::Entry
    user = ActiveDirectory.get_user(user)
    return false if user.nil?
  end
  unless group.is_a? Net::LDAP::Entry
    group = ActiveDirectory.get_group(group)
  end

  ensure_sentinel_descriptor_presence(group)

  ActiveDirectory.remove_user_from_group(user, group)
end

# The sentinel descriptor used by ensure_sentinel_descriptor_presence
SENTINEL_DESCRIPTOR = "(RM Sync)"

# Adds the SENTINEL_DESCRIPTOR text to an AD group's description field if
# it is not present.
#
# +group+ is a Net::LDAP::Entry object or a string
def ensure_sentinel_descriptor_presence(group)
  unless group.is_a? Net::LDAP::Entry
    group = ActiveDirectory.get_group(group)
  end

  return false if group.nil?

  g_desc = group[:description][0]
  g_desc = "" if g_desc.nil?

  # Ensure the sentinel exists
  unless g_desc.index SENTINEL_DESCRIPTOR
    STDOUT.puts "Adding '#{SENTINEL_DESCRIPTOR}' to AD group description."
    g_desc = "#{SENTINEL_DESCRIPTOR} #{g_desc}"
    ActiveDirectory.update_group_description(group, g_desc)
  end
end

# Removes the SENTINEL_DESCRIPTOR text from an AD group's description field if
# it is present.
#
# +group+ is a Net::LDAP::Entry object or a string
def ensure_sentinel_descriptor_absence(group)
  unless group.is_a? Net::LDAP::Entry
    group = ActiveDirectory.get_group(group)
  end
  
  return false if group.nil?

  g_desc = group[:description][0]

  if g_desc and g_desc.index SENTINEL_DESCRIPTOR
    STDOUT.puts "Removing '#{SENTINEL_DESCRIPTOR}' from AD group description."
    g_desc.slice! "(RM Sync)"
    g_desc.lstrip!
    ActiveDirectory.update_group_description(group, g_desc)
  end
end

# Retrieves all members from both the role in RM and the AD group and ensures
# both have the same members by adding any missing members from one to the other
# (inclusively).
def merge_role_and_ad_group(role_id, group_name)
  ad_group = ActiveDirectory.get_group(group_name)

  unless ad_group.is_a? Net::LDAP::Entry
    abort("Could not retrieve #{group_name}")
  end

  rm_client = RolesManagementAPI.login(@config['rm_endpoint']['host'], @config['rm_endpoint']['user'], @config['rm_endpoint']['pass'])

  abort("Could not connect to RM to merge role and AD group") unless rm_client.connected?

  role = rm_client.find_role_by_id(role_id)

  # Add any role members to the AD group
  role.members.each do |member|
    ensure_user_in_group(member.loginid, ad_group)
  end

  # Simple flag to avoid unnecessary RM activity
  role_changed = false

  # Add any AD group members to the role
  ActiveDirectory.list_group_members(ad_group).each do |ad_member|
    p = rm_client.find_person_by_loginid(ad_member)
    if p
      unless role.members.map{ |m| m.loginid }.include? p.loginid
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
def ou_to_short(name)
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
def flatten_affiliation(affiliation)
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
    "visitor"
    return nil
  else
    STDERR.puts "AD Sync: Missing affiliation for translation to container name: #{affiliation}"
  end

  return false
end

# -----------------------
#  Start of main script.
# -----------------------

begin
  @sync_data = JSON.parse(STDIN.read)
rescue JSON::ParserError
  abort "JSON::ParserError: Input does not appear to be valid JSON."
end

@config = YAML.load_file(@sync_data["config_path"] + "/active_directory.yml")

ActiveDirectory.configure(@config)

case @sync_data["mode"]

when "add_to_system"
  ensure_user_in_group(@sync_data["person"]["loginid"], 'dss-us-auto-all', nil)
  exit(0)

when "remove_from_system"
  ensure_user_not_in_group(@sync_data["person"]["loginid"], 'dss-us-auto-all', nil)
  exit(0)

when "add_to_role"
  # If ad_path and ad_guid are nil, return success (we don't respond to non-AD roles)
  exit(0) unless @sync_data["role"]["ad_path"] #or @sync_data["role"]["ad_guid"]
  ensure_user_in_group(@sync_data["person"]["loginid"], @sync_data["role"]["ad_path"]) #, @sync_data["role"]["ad_guid"])
  exit(0)

when "remove_from_role"
  # If ad_path and ad_guid are nil, return success (we don't respond to non-AD roles)
  exit(0) unless @sync_data["role"]["ad_path"] #or @sync_data["role"]["ad_guid"]
  ensure_user_not_in_group(@sync_data["person"]["loginid"], @sync_data["role"]["ad_path"]) #, @sync_data["role"]["ad_guid"])
  exit(0)

when "add_to_organization"
  @sync_data["person"]["affiliations"].each do |affiliation|
    # Write them to cluster-name-affiliation (dss-us-#{ou_to_short}-#{flatten_affiliation})
    short_ou = ou_to_short(@sync_data["organization"]["name"])
    flattened_affiliation = flatten_affiliation(affiliation)

    # Skip unknown or ignored translations
    next if ((short_ou == false) || (flattened_affiliation == false) || (short_ou == nil) || (flattened_affiliation == nil))

    # Write them to cluster-affiliation-all
    ensure_user_in_group(@sync_data["person"]["loginid"], "dss-us-#{short_ou}-#{flattened_affiliation}".downcase)

    # Write them to cluster-all (dss-us-#{ou_to_short}-all)
    ensure_user_in_group(@sync_data["person"]["loginid"], "dss-us-#{short_ou}-all".downcase)
  end

  exit(0)

when "remove_from_organization"
  @sync_data["person"]["affiliations"].each do |affiliation|
    # Remove them from cluster-name-affiliation (dss-us-#{ou_to_short}-#{flatten_affiliation})
    short_ou = ou_to_short(@sync_data["organization"]["name"])
    flattened_affiliation = flatten_affiliation(affiliation)

    # Skip unknown or ignored translations
    next if ((short_ou == false) || (flattened_affiliation == false) || (short_ou == nil) || (flattened_affiliation == nil))

    # Remove them from cluster-affiliation-all
    ensure_user_not_in_group(@sync_data["person"]["loginid"], "dss-us-#{short_ou}-#{flattened_affiliation}".downcase)

    # Remove them from cluster-all (dss-us-#{ou_to_short}-all)
    ensure_user_not_in_group(@sync_data["person"]["loginid"], "dss-us-#{short_ou}-all".downcase)
  end

  exit(0)

when "role_change"
  @sync_data["role"]["changes"].each do |field, values|
    if field == "ad_path"
      if (values[0] == nil) and (values[1] != nil)
        # AD path set for the first time. Merge role and AD group.
        merge_role_and_ad_group(@sync_data["role"]["id"], values[1])
      elsif (values[0] != nil) and (values[1] == nil)
        # AD path was set but is now unset. Leave all members but remove sentinel
        ensure_sentinel_descriptor_absence(values[0])
      else
        # AD path went from one non-empty value to another non-empty value.
        # Leave the users in the first group (removing the sentienl) but
        # merge the second AD path with the role.
        ensure_sentinel_descriptor_absence(values[0])

        merge_role_and_ad_group(@sync_data["role"]["id"], values[1])
      end
    end
  end

  exit(0)

else
  abort "This script does not understand sync mode: #{@sync_data["mode"]}"
end

# We will only get here on error.
exit(1)
