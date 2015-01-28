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
require 'active_directory'

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
    break unless u.nil?
  end

  u
end

# Takes name as a string (e.g. 'this-that') and returns an ActiveDirectory::Group object
def fetch_ad_group(group_name)
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
    ActiveDirectory::Group.find(:first, :cn => group_name)
  rescue SystemCallError
    # Usually occurs when AD can't be reached (times out)
    return nil
  end
end

# Takes objectGuid as a hex string and returns an ActiveDirectory::Group object
def fetch_ad_group_by_guid(guid)
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
    ActiveDirectory::Group.find(:first, :objectguid => guid)
  rescue SystemCallError
    # Usually occurs when AD can't be reached (times out)
    return nil
  end
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

  group.remove user
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
    ad_group.description = "#{MAGIC_DESCRIPTOR} #{g_desc}"
    ad_group.save
  end
end

# -----------------------
#  Start of main script.
# -----------------------

abort "This job is purposefully failing for debug purposes."

begin
  @sync_data = JSON.parse(STDIN.read)
rescue JSON::ParserError
  abort "JSON::ParserError: Input does not appear to be valid JSON."
end

@config = YAML.load_file(@sync_data["config_path"] + "/active_directory.yml")

require 'pp'
pp @sync_data

case @sync_data["mode"]
when "add_to_system"
  puts "add_to_system"

when "remove_from_system"
  puts "remove_from_system"

when "add_to_role"
  puts "trying add_to_role ... (token: #{@sync_data["role"]["token"]} for loginid: #{@sync_data["person"]["loginid"]})"

  if @sync_data["role"]["ad_path"]
    if @sync_data["role"]["ad_guid"]
      g = fetch_ad_group_by_guid(@sync_data["role"]["ad_guid"])
    else
      g = fetch_ad_group(@sync_data["role"]["ad_path"])
      # FIXME: What are we going to do about AD-specific information (or syncing specific information in general?)
      # Record GUID as this is our preferred method of finding an existing group
      #r.ad_guid = g.objectguid unless g.nil?
    end

    if g
      ensure_magic_descriptor_presence(g)

      # FIXME: What are we going to do about AD-specific information (or syncing specific information in general?)
      # Ensure name is up-to-date as GUID-based lookups allow for object name changes without affecting us
      #r.ad_path = g.cn

      # Add person to AD
      u = fetch_ad_user(@sync_data["person"]["loginid"])
      unless in_ad_group?(u, g)
        if add_user_to_group(u, g) == false
          #ActivityLog.err!("Needed to add #{member.name} to AD group #{r.ad_path} but the operation failed.", ["person_#{member.id}", "role_#{r.id}", "application_#{r.application_id}", 'active_directory'])
          STDERR.puts "AD add operation failed."
          exit(1)
        else
          #ActivityLog.record!("Added #{member.name} to AD group #{r.ad_path}.", ["person_#{member.id}", "role_#{r.id}", "application_#{r.application_id}", 'active_directory'])
          STDOUT.puts "AD add operation succeeded."
          exit(0)
        end
      #else
        #log.info "User #{member.loginid} is already in AD group #{r.ad_path}"
      end
    else
      STDERR.puts "Could not find AD group using GUID \"#{@sync_data["role"]["ad_guid"]}\" or path \"#{@sync_data["role"]["ad_path"]}\""
      exit(1)
    end
  else
    STDOUT.puts "Doing nothing as AD path not set."
    exit(0)
  end

when "remove_from_role"
  puts "remove_from_role"

when "activate_person"
  puts "activate_person"

when "deactivate_person"
  puts "deactivate_person"

else
  abort "This script does not understand sync mode: #{@sync_data["mode"]}"
end
