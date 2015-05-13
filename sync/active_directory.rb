#! /usr/bin/env ruby

# Concerns migrating this away from the main RM program:
#   * ensure_magic_descriptor_presence() is currently broken
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
require 'active_directory'
require 'logger'

# Takes loginid as a string (e.g. 'jsmith') and returns an ActiveDirectory::User object
def fetch_ad_user(loginid)
  u = nil

  @config['ad_people'].each do |entry|
    settings = {
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

    ActiveDirectory::Base.setup(settings)
    u = ActiveDirectory::User.find(:first, :samaccountname => loginid)
    @logger.info "#{Time.now} fetch_ad_user() called for #{loginid}"
    break unless u.nil?
  end

  return u
end

# Takes name as a string (e.g. 'this-that') and returns an ActiveDirectory::Group object
def fetch_ad_group(group_name)
  g = nil

  settings = {
      :host => @config['ad_groups']['host'],
      :base => @config['ad_groups']['base'],
      :port => 636,
      :encryption => :simple_tls,
      :auth => {
        :method => :simple,
        :username => @config['ad_groups']['user'],
        :password => @config['ad_groups']['pass']
      }
  }

  ActiveDirectory::Base.setup(settings)

  begin
    g = ActiveDirectory::Group.find(:first, :cn => group_name)
    @logger.info "#{Time.now} fetch_ad_group() called for #{group_name}"
  rescue SystemCallError
    # Usually occurs when AD can't be reached (times out)
    return nil
  end

  return g
end

# Takes objectGuid as a hex string and returns an ActiveDirectory::Group object
def fetch_ad_group_by_guid(guid)
  g = nil

  settings = {
      :host => @config['ad_groups']['host'],
      :base => @config['ad_groups']['base'],
      :port => 636,
      :encryption => :simple_tls,
      :auth => {
        :method => :simple,
        :username => @config['ad_groups']['user'],
        :password => @config['ad_groups']['pass']
      }
  }

  ActiveDirectory::Base.setup(settings)

  begin
    g = ActiveDirectory::Group.find(:first, :objectguid => guid)
    @logger.info "#{Time.now} fetch_ad_group_by_guid() called for #{guid}"
  rescue SystemCallError
    # Usually occurs when AD can't be reached (times out)
    return nil
  end

  return g
end

# Takes name as a string (e.g. 'this-that') and returns true or false
def ad_group_exists?(group_name)
  if fetch_ad_group(group_name).nil?
    return false
  else
    return true
  end
end

# Takes user as an ActiveDirectory::User object and group as a ActiveDirectory::Group object and returns boolean
def add_user_to_group(user, group)
  if group.nil?
    return false
  end

  settings = {
      :host => @config['ad_groups']['host'],
      :base => @config['ad_groups']['base'],
      :port => 636,
      :encryption => :simple_tls,
      :auth => {
        :method => :simple,
        :username => @config['ad_groups']['user'],
        :password => @config['ad_groups']['pass']
      }
  }

  ActiveDirectory::Base.setup(settings)

  @logger.info "#{Time.now} add_user_to_group() called for user #{user}, group #{group}"
  group.add user
end

# Takes group as an ActiveDirectory::Group object and returns an array of users
def list_group_members(group)
  members = []

  if group.nil?
    return []
  end

  @config['ad_people'].each do |entry|
    settings = {
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

    ActiveDirectory::Base.setup(settings)

    begin
      @logger.info "#{Time.now} list_group_members() called for #{group}"
      members += group.member_users
    rescue NoMethodError
      # active_directory gem throws a NoMethodError if the group is blank
    end
  end

  members
end

# Returns true if 'user' is in 'group' (both objects should be queried using fetch_user and fetch_group)
def in_ad_group?(user, group)
  settings = {
      :host => @config['ad_groups']['host'],
      :base => @config['ad_groups']['base'],
      :port => 636,
      :encryption => :simple_tls,
      :auth => {
        :method => :simple,
        :username => @config['ad_groups']['user'],
        :password => @config['ad_groups']['pass']
      }
  }

  ActiveDirectory::Base.setup(settings)

  begin
    unless user.nil? or group.nil?
      @logger.info "#{Time.now} in_ad_group?() called for user #{user}, group #{group}"
      if user.member_of? group
        return true
      end
    end
  rescue ArgumentError
    # puts "Skipping user due to ArgumentError exception"
    return false
  end

  return false
end

def remove_user_from_group(user, group)
  if group.nil?
    return false
  end

  settings = {
      :host => @config['ad_groups']['host'],
      :base => @config['ad_groups']['base'],
      :port => 636,
      :encryption => :simple_tls,
      :auth => {
        :method => :simple,
        :username => @config['ad_groups']['user'],
        :password => @config['ad_groups']['pass']
      }
  }

  ActiveDirectory::Base.setup(settings)

  @logger.info "#{Time.now} remove_user_from_group() called for user #{user}, group #{group}"
  group.remove user
end

# User may be a loginid (string) or ActiveDirectory::User object
# Group may be an AD path (string) or ActiveDirectory::Group object
# ad_guid may be provided (optional) and will be prefered over AD Path if
# 'group' is a string (AD Path)
def ensure_user_in_group(user, group, ad_guid = nil)
  if user.is_a? ActiveDirectory::User
    u = user
  else
    u = fetch_ad_user(user)
    if u.nil?
      STDERR.puts "Could not find AD user \"#{user}\""
      return false
    end
  end

  if group.is_a? ActiveDirectory::Group
    g = group
  else
    if ad_guid
      g = fetch_ad_group_by_guid(ad_guid)
    else
      g = fetch_ad_group(group)
    end
    if g.nil?
      STDERR.puts "Could not find AD group using GUID \"#{ad_guid}\" or path \"#{group}\""
      return false
    end
  end

  # TODO: Maybe call this sentinel.
  ensure_magic_descriptor_presence(g)

  unless in_ad_group?(u, g)
    if add_user_to_group(u, g)
      STDOUT.puts "AD add operation succeeded."
      return true
    else
      STDERR.puts "AD add operation failed."
      return false
    end
  else
    STDOUT.puts "AD add operation unnecessary, user is already in group."
    return true
  end

  return false
end

# User may be a loginid (string) or ActiveDirectory::User object
# Group may be an AD path (string) or ActiveDirectory::Group object
# ad_guid may be provided (optional) and will be prefered over AD Path if
# 'group' is a string (AD Path)
def ensure_user_not_in_group(user, group, ad_guid = nil)
  if user.is_a? ActiveDirectory::User
    u = user
  else
    u = fetch_ad_user(user)
    if u.nil?
      STDERR.puts "Could not find AD user \"#{user}\""
      return false
    end
  end

  if group.is_a? ActiveDirectory::Group
    g = group
  else
    if ad_guid
      g = fetch_ad_group_by_guid(ad_guid)
    else
      g = fetch_ad_group(group)
    end
    if g.nil?
      STDERR.puts "Could not find AD group using GUID \"#{ad_guid}\" or path \"#{group}\""
      return false
    end
  end

  ensure_magic_descriptor_presence(g)

  if in_ad_group?(u, g)
    if remove_user_from_group(u, g)
      STDOUT.puts "AD remove operation succeeded."
      return true
    else
      STDERR.puts "AD remove operation failed."
      return false
    end
  else
    STDOUT.puts "AD remove operation unnecessary, user is not in group."
    return true
  end

  return false
end

# The magic descriptor used by ensure_magic_descriptor_presence
MAGIC_DESCRIPTOR = "(RM Sync)"

# Adds the MAGIC_DESCRIPTOR text to an AD group's description field if
# it is not present.
#
# +ad_group+ is an AD group object required by the active_record gem
def ensure_magic_descriptor_presence(ad_group)
  # Use exceptions as activedirectory gem will throw an ArgumentError if no description exists.
  # AD groups don't have to have description fields but we will add one if needed.
  begin
    g_desc = ad_group.description
  rescue ArgumentError, NoMethodError
    # description not set
    g_desc = ""
  end

  unless g_desc and g_desc.index MAGIC_DESCRIPTOR
    STDOUT.puts "Added '#{MAGIC_DESCRIPTOR}' to AD group description."
    ad_group.description = "#{MAGIC_DESCRIPTOR} #{g_desc}"
    ad_group.save
  end
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
    STDOUT.puts "AD Sync: Missing OU for translation to container name: #{name}"
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
    STDOUT.puts "AD Sync: Missing affiliation for translation to container name: #{affiliation}"
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

@logger = Logger.new(@sync_data["config_path"] + "/../../log/active_directory_activity.log", 10, 1024000)

case @sync_data["mode"]

when "add_to_system"
  exit(0) if ensure_user_in_group(@sync_data["person"]["loginid"], 'dss-us-auto-all', nil)

when "remove_from_system"
  exit(0) if ensure_user_not_in_group(@sync_data["person"]["loginid"], 'dss-us-auto-all', nil)

when "add_to_role"
  # If ad_path and ad_guid are nil, return success (we don't respond to non-AD roles)
  exit(0) unless @sync_data["role"]["ad_path"] #or @sync_data["role"]["ad_guid"]
  exit(0) if ensure_user_in_group(@sync_data["person"]["loginid"], @sync_data["role"]["ad_path"]) #, @sync_data["role"]["ad_guid"])

when "remove_from_role"
  # If ad_path and ad_guid are nil, return success (we don't respond to non-AD roles)
  exit(0) unless @sync_data["role"]["ad_path"] #or @sync_data["role"]["ad_guid"]
  exit(0) if ensure_user_not_in_group(@sync_data["person"]["loginid"], @sync_data["role"]["ad_path"]) #, @sync_data["role"]["ad_guid"])

when "add_to_organization"
  ad_user = fetch_ad_user(@sync_data["person"]["loginid"])

  abort("Could not find AD user \"#{@sync_data["person"]["loginid"]}\"") if ad_user.nil?

  @sync_data["person"]["affiliations"].each do |affiliation|
    # Write them to cluster-name-affiliation (dss-us-#{ou_to_short}-#{flatten_affiliation})
    short_ou = ou_to_short(@sync_data["organization"]["name"])
    flattened_affiliation = flatten_affiliation(affiliation)

    # Skip unknown or ignored translations
    next if ((short_ou == false) || (flattened_affiliation == false) || (short_ou == nil) || (flattened_affiliation == nil))

    # Write them to cluster-affiliation-all
    abort unless ensure_user_in_group(ad_user, "dss-us-#{short_ou}-#{flattened_affiliation}".downcase)

    # Write them to cluster-all (dss-us-#{ou_to_short}-all)
    abort unless ensure_user_in_group(ad_user, "dss-us-#{short_ou}-all".downcase)
  end

  exit(0)

when "remove_from_organization"
  ad_user = fetch_ad_user(@sync_data["person"]["loginid"])

  abort("Could not find AD user \"#{@sync_data["person"]["loginid"]}\"") if ad_user.nil?

  @sync_data["person"]["affiliations"].each do |affiliation|
    # Remove them from cluster-name-affiliation (dss-us-#{ou_to_short}-#{flatten_affiliation})
    short_ou = ou_to_short(@sync_data["organization"]["name"])
    flattened_affiliation = flatten_affiliation(affiliation)

    # Skip unknown or ignored translations
    next if ((short_ou == false) || (flattened_affiliation == false) || (short_ou == nil) || (flattened_affiliation == nil))

    # Remove them from cluster-affiliation-all
    abort unless ensure_user_not_in_group(ad_user, "dss-us-#{short_ou}-#{flattened_affiliation}".downcase)

    # Remove them from cluster-all (dss-us-#{ou_to_short}-all)
    abort unless ensure_user_not_in_group(ad_user, "dss-us-#{short_ou}-all".downcase)
  end

  exit(0)

when "role_change"
  @sync_data["role"]["changes"].each do |field, values|
    if field == "ad_path"
      if (values[0] == nil) and (values[1] != nil)
        # AD path set for the first time. Add all members to the AD group.
        # TODO: Should be a merge, not a one-way sync
        @sync_data["role"]["members"].each do |loginid|
          abort unless ensure_user_in_group(loginid, values[1])
        end
      elsif (values[0] != nil) and (values[1] == nil)
        # AD path was set but is now unset. Remove all members from the AD group.
        # TODO: Remove the (RM Sync) sentinel but do not remove the members
        @sync_data["role"]["members"].each do |loginid|
          abort unless ensure_user_not_in_group(loginid, values[0])
        end
      else
        # AD path went from one non-empty value to another non-empty value.
        # Remove users from the first group and add them to the second.
        # TODO: Leave the first group alone (removing the sentienl)
        #       perform the fist-time merge on the second group
        @sync_data["role"]["members"].each do |loginid|
          abort unless ensure_user_not_in_group(loginid, values[0])
        end
        @sync_data["role"]["members"].each do |loginid|
          abort unless ensure_user_in_group(loginid, values[1])
        end
      end
    end
  end

  exit(0)

else
  abort "This script does not understand sync mode: #{@sync_data["mode"]}"
end

# We will only get here on error.
exit(1)
