#! /usr/bin/env ruby

require 'json'
require 'yaml'

require 'rubygems'
require 'bundler/setup'

require 'sysaid'

DEBUG_SOAP = false

# COMPANIES and DEPARTMENTS are hard-coded per UCD DSS IT's SysAid installation
COMPANIES = []
COMPANIES[6] = "POLI SCI, IR ORANGE CLUSTER"
COMPANIES[7] = "L&S DEANS - SOCIAL SCIENCES"
COMPANIES[8] = "ECON, HIS, MS BLUE CLUSTER"
COMPANIES[9] = "ANT, SOC GREEN CLUSTER"
COMPANIES[10] = "PSYCH, CMB YELLOW CLUSTER"
COMPANIES[11] = "COM, PHIL & LIN RED CLUSTER"

DEPARTMENTS = []
DEPARTMENTS[1] = "ANT, SOC GREEN CLUSTER"
DEPARTMENTS[2] = "ANTHROPOLOGY"
DEPARTMENTS[3] = "CALIFORNIA HISTORY SS PROJECT"
DEPARTMENTS[4] = "CENTER FOR INNOVATION STUDIES"
DEPARTMENTS[5] = "CENTER FOR MIND AND BRAIN"
DEPARTMENTS[6] = "COM, PHIL & LIN RED CLUSTER"
DEPARTMENTS[7] = "COMMUNICATION"
DEPARTMENTS[8] = "DSS HR/PAYROLL SERVICE CENTER"
DEPARTMENTS[9] = "DSS IT SERVICE CENTER"
DEPARTMENTS[10] = "DSS RESEARCH SERVICE CENTER"
DEPARTMENTS[11] = "ECON, HIS, MS BLUE CLUSTER"
DEPARTMENTS[12] = "ECONOMICS"
DEPARTMENTS[13] = "GEOGRAPHY"
DEPARTMENTS[14] = "HEMISPHERIC INSTITUTE-AMERICAS"
DEPARTMENTS[15] = "HISTORY"
DEPARTMENTS[16] = "INTERNATIONAL RELATIONS"
DEPARTMENTS[17] = "L&S DEANS - SOCIAL SCIENCES"
DEPARTMENTS[18] = "LINGUISTICS"
DEPARTMENTS[19] = "MICROBIOLOGY"
DEPARTMENTS[20] = "MIDDLE EAST/SOUTH ASIA PROGRAM"
DEPARTMENTS[21] = "MILITARY SCIENCE"
DEPARTMENTS[22] = "PHILOSOPHY"
DEPARTMENTS[23] = "PHYSICAL EDUCATION PROGRAM"
DEPARTMENTS[24] = "POLI SCI, IR ORANGE CLUSTER"
DEPARTMENTS[25] = "POLITICAL SCIENCE"
DEPARTMENTS[26] = "PSYCH, CMB YELLOW CLUSTER"
DEPARTMENTS[27] = "PSYCHOLOGY"
DEPARTMENTS[28] = "SCIENCE & TECHNOLOGY STUDIES"
DEPARTMENTS[29] = "SOCIAL SCIENCES PROGRAM"
DEPARTMENTS[30] = "SOCIOLOGY"
DEPARTMENTS[31] = "TEMPORARY EMPLOYMENT SERVICES"
DEPARTMENTS[32] = "HISTORY PROJECT"

def log_into_sysaid
  begin
    SysAid::login @config['account'], @config['user'], @config['password'], @config['uri'], DEBUG_SOAP
  rescue Exception => e
    STDERR.puts "Unable to login to SysAid: #{e}"
    return false
  end

  return true
end

def add_user_to_sysaid(person_sync_data)
  begin
    user = SysAid::User.find_by_username(person_sync_data["loginid"])
    if user.nil?
      # User does not already exist. Create them.
      user = SysAid::User.new(person_sync_data["loginid"])
      #STDOUT.puts "User does not already exist in SysAid. Creating ..."
    else
      #STDOUT.puts "User already exists in SysAid. Updating ..."
    end

    if user.admin
      #logger.info "\t\tSkipping existing SysAid admin user (by design)"
      return true
    end

    user.login_user = person_sync_data["loginid"]
    user.login_domain = "AD3"
    user.admin = false
    user.building = person_sync_data["address"]
    user.disable = false
    user.display_name = person_sync_data["name"]
    user.email = person_sync_data["email"]
    user.first_name = person_sync_data["first"]
    user.last_name = person_sync_data["last"]
    user.cust_text1 = person_sync_data["title"]
    user.cust_text2 = person_sync_data["affiliations"][0] unless person_sync_data["affiliations"].length == 0
    user.phone = person_sync_data["phone"]
    user.enable_login_to_eup = true

    unknown_ous = []
    # Any OUs? If so, search in DEPARTMENTS and COMPANIES
    person_sync_data["organizations"].each do |ou|
      c_idx = COMPANIES.index ou
      d_idx = DEPARTMENTS.index ou

      if c_idx
        # User is in an OU matching the name of a SysAid Company
        user.company = c_idx.to_s
      end

      if d_idx
        # User is in an OU matching the name of a SysAid Department
        user.department = d_idx.to_s
      end

      if not c_idx and not d_idx
        unknown_ous << ou.name
      end
    end

    if person_sync_data["organizations"].length == 0
      #STDOUT.puts "User '#{loginid}' has no OUs in RM so they will not have a Company or Department in SysAid. Maybe local Company/Department list needs updating?"
    end

    if user.company.nil?
      STDOUT.puts "Unable to assign user '#{person_sync_data["loginid"]}' a Company. User either has no OUs in RM or none of their OUs matched the existing SysAid Company/Department list stored locally. Maybe that list needs updating? The following unknown OUs were seen with this user: #{unknown_ous}."
    end
    if user.department.nil?
      STDOUT.puts "Unable to assign user '#{person_sync_data["loginid"]}' a Department. User either has no OUs in RM or none of their OUs matched the existing SysAid Company/Department list stored locally. Maybe that list needs updating? The following unknown OUs were seen with this user: #{unknown_ous}."
    end

    if user.save
      STDOUT.puts "User #{person_sync_data["loginid"]} saved to SysAid."
      return true
    else
      STDERR.puts "Error while saving user #{person_sync_data["loginid"]}!"
      return false
    end
  rescue SysAidException => e
    STDERR.puts "Caught SysAid exception: #{e}"
    return false
  rescue Errno::ECONNREFUSED => e
    STDERR.puts "Unable to connect to server. Exception: #{e}"
    return false
  rescue Net::ReadTimeout => e
    STDERR.puts "Connection timed out while talking to SysAid. Exception: #{e}"
    return false
  rescue Errno::ETIMEDOUT => e
    STDERR.puts "Connection timed out while talking to SysAid. Exception: #{e}"
    return false
  rescue Errno::ECONNRESET => e
    STDERR.puts "Connection error while talking to SysAid. Exception: #{e}"
    return false
  rescue Savon::HTTPError => e
    STDERR.puts "The SysAid server returned an invalid SOAP response. Exception: #{e}"
    return false
  rescue Savon::UnknownOperationError => e
    STDERR.puts "An unknown error occurred while talking to the SysAid server. Exception: #{e}"
    return false
  end

  return true
end

def remove_user_from_sysaid(person_sync_data)
  begin
    user = SysAid::User.find_by_username(person_sync_data["loginid"])
    if user.nil?
      # User doesn't exist in SysAid, so we're effectively done with our task
      return true
    end

    if user.admin
      # By design we will not remove any admin users using this script
      return false
    end

    if user.delete
      STDOUT.puts "User #{person_sync_data["loginid"]} deleted from SysAid."
      return true
    else
      STDERR.puts "Error while deleting user #{person_sync_data["loginid"]}!"
      return false
    end
  rescue SysAidException => e
    STDERR.puts "Caught SysAid exception: #{e}"
    return false
  rescue Errno::ECONNREFUSED => e
    STDERR.puts "Unable to connect to server. Exception: #{e}"
    return false
  rescue Net::ReadTimeout => e
    STDERR.puts "Connection timed out while talking to SysAid. Exception: #{e}"
    return false
  rescue Errno::ETIMEDOUT => e
    STDERR.puts "Connection timed out while talking to SysAid. Exception: #{e}"
    return false
  rescue Errno::ECONNRESET => e
    STDERR.puts "Connection error while talking to SysAid. Exception: #{e}"
    return false
  rescue Savon::HTTPError => e
    STDERR.puts "The SysAid server returned an invalid SOAP response. Exception: #{e}"
    return false
  rescue Savon::UnknownOperationError => e
    STDERR.puts "An unknown error occurred while talking to the SysAid server. Exception: #{e}"
    return false
  end

  return true
end

# -----------------------
#  Start of main script.
# -----------------------

begin
  @sync_data = JSON.parse(STDIN.read)
rescue JSON::ParserError
  abort "JSON::ParserError: Input does not appear to be valid JSON."
end

@config = YAML.load_file(@sync_data["config_path"] + "/sysaid.yml")

case @sync_data["mode"]

when "add_to_system"
  exit(0) # We don't care about this

when "remove_from_system"
  exit(0) # We don't care about this

when "add_to_role"
  if @sync_data["role"]["id"].to_s == "111" and @sync_data["role"]["token"] == "import"
    abort unless log_into_sysaid
    abort unless add_user_to_sysaid(@sync_data["person"])

    exit(0)
  else
    exit(0) # We don't care about this
  end

when "remove_from_role"
  if @sync_data["role"]["id"].to_s == "111" and @sync_data["role"]["token"] == "import"
    abort unless log_into_sysaid
    abort unless remove_user_from_sysaid(@sync_data["person"])

    exit(0)
  else
    exit(0) # We don't care about this
  end

when "add_to_organization"
  exit(0) # We don't care about this

when "remove_from_organization"
  exit(0) # We don't care about this

else
  abort "This script does not understand sync mode: #{@sync_data["mode"]}"
end

# We will only get here on error.
exit(1)
