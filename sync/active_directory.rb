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

STDERR.puts "This script shouuld not be used anymore."
exit(1)

# require 'json'
# require 'yaml'

# begin
#   @sync_data = JSON.parse(STDIN.read)
# rescue JSON::ParserError
#   abort 'JSON::ParserError: Input does not appear to be valid JSON.'
# end

# load "#{@sync_data['config_path']}/../../lib/active_directory.rb"
# load "#{@sync_data['config_path']}/../../lib/active_directory_helper.rb"

# @config = YAML.load_file(@sync_data['config_path'] + '/active_directory.yml')

# ActiveDirectory.configure(@config)

# case @sync_data['mode']

# when 'add_to_system'
#   # AD does not use this trigger
#   exit(0)

# when 'remove_from_system'
#   # AD does not use this trigger
#   exit(0)

# when 'add_to_role'
#   loginid = @sync_data['person']['loginid']
#   ad_path = @sync_data['role']['ad_path']
#   application_name = @sync_data['role']['application_name']
#   role_name = @sync_data['role']['role_name']

#   if ad_path.nil? || ad_path.empty?
#     STDOUT.puts 'Ignoring remove_from_role: no ad_path given. (This is normal for any role without an AD path.)'
#     exit(0)
#   end

#   # If ad_path and ad_guid are nil, return success (we don't respond to non-AD roles)
#   STDOUT.puts "Adding #{loginid} to role represented in #{ad_path} ..."
#   STDOUT.puts "Ensuring #{loginid} is in AD group #{ad_path} ..."
  
#   begin
#     if ActiveDirectoryHelper.ensure_user_in_group(loginid, ad_path) == false
#       STDERR.puts "Error occurred while ensuring user '#{loginid}' was in group '#{ad_path}'"
#       exit(1)
#     end
#   rescue ActiveDirectoryHelper::UserNotFound, ActiveDirectoryHelper::GroupNotFound
#     STDERR.puts "User or group not found while ensuring user '#{loginid}' was in group '#{ad_path}'"
#     exit(1)
#   end

#   if ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(ad_path, application_name, role_name) == false
#     STDERR.puts "Error occurred while updating AD group description for '#{ad_path}'"
#     exit(1)
#   end

#   STDOUT.puts 'Success!'

#   exit(0)

# when 'remove_from_role'
#   ad_path = @sync_data['role']['ad_path']
#   loginid = @sync_data['person']['loginid']
#   application_name = @sync_data['role']['application_name']
#   role_name = @sync_data['role']['role_name']

#   if ad_path.nil? || ad_path.empty?
#     STDOUT.puts 'Ignoring remove_from_role: no ad_path given. (This is normal for any role without an AD path.)'
#     exit(0)
#   end

#   # If ad_path and ad_guid are nil, return success (we don't respond to non-AD roles)
#   STDOUT.puts "Removing #{loginid} from role represented in #{ad_path} ..."
#   STDOUT.puts "Ensuring #{loginid} is not in AD group #{ad_path} ..."

#   begin
#     if ActiveDirectoryHelper.ensure_user_not_in_group(loginid, ad_path) == false
#       STDERR.puts "Error occurred while ensuring user '#{loginid}' was not in group '#{ad_path}'"
#       exit(1)
#     end
#   rescue ActiveDirectoryHelper::UserNotFound
#     STDOUT.puts "User '#{loginid}' not found in AD while answering a 'remove_from_role'. Ignoring."
#   rescue ActiveDirectoryHelper::GroupNotFound
#     STDERR.puts "Group '#{ad_path}' not found in AD while answering a 'remove_from_role'. Please ensure group exists."
#     exit(1)
#   end

#   if ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(ad_path, application_name, role_name) == false
#     STDERR.puts "Error occurred while updating AD group description for '#{ad_path}'"
#     exit(1)
#   end

#   STDOUT.puts 'Success!'

#   exit(0)

# when 'add_to_organization'
#   # AD does not use this trigger

#   exit(0)

# when 'remove_from_organization'
#   # AD does not use this trigger

#   exit(0)

# when 'role_change'
#   @sync_data['role']['changes'].each do |field, values|
#     next unless field == 'ad_path'

#     rm_client = RolesManagementAPI.login(@config['rm_endpoint']['host'], @config['rm_endpoint']['user'], @config['rm_endpoint']['pass'])
#     abort('Could not connect to RM to merge role and AD group') unless rm_client.connected?

#     old_value = values[0]
#     new_value = values[1]

#     # Clean up for a previous RM bug which erroneously created sync_jobs for
#     # ad_path values changing from nil to "".
#     old_value = nil if old_value && old_value.empty?
#     new_value = nil if new_value && new_value.empty?
#     exit(0) if old_value.nil? && new_value.nil?

#     if (old_value == nil) && (new_value != nil)
#       # AD path set for the first time. Merge role and AD group.
#       ActiveDirectoryHelper.merge_role_and_ad_group(@sync_data['role']['id'], new_value, rm_client)
#       ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(new_value, @sync_data['role']['application_name'], @sync_data['role']['role_name'])
#     elsif (old_value != nil) && (new_value == nil)
#       # AD path was set but is now unset. Leave all members but remove sentinel
#       ActiveDirectoryHelper.ensure_sentinel_descriptor_absence(old_value)
#     else
#       # AD path went from one non-empty value to another non-empty value.
#       # Leave the users in the first group (removing the sentinel) but
#       # merge the second AD path with the role.
#       ActiveDirectoryHelper.ensure_sentinel_descriptor_absence(old_value)

#       ActiveDirectoryHelper.merge_role_and_ad_group(@sync_data['role']['id'], new_value, rm_client)
#       ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(new_value, @sync_data['role']['application_name'], @sync_data['role']['role_name'])
#     end
#   end

#   exit(0)

# when 'role_audit'
#   ad_path = @sync_data['role']['ad_path']
#   role_members = @sync_data['role']['members']
#   application_name = @sync_data['role']['application_name']
#   role_name = @sync_data['role']['role_name']

#   ad_group = ActiveDirectory.get_group(ad_path)

#   unless ad_group.is_a? Net::LDAP::Entry
#     STDERR.puts "Error syncing role. Could not retrieve '#{ad_path}' from AD."
#     exit(1)
#   end

#   ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(ad_group, application_name, role_name)

#   ad_members = ActiveDirectory.list_group_members(ad_group)
#   # role_members = role.members.select { |m| m.active == true }.map(&:loginid)

#   if ad_members.sort == role_members.sort
#     STDOUT.puts 'Role is already fully synced.'
#     exit(0)
#   else
#     STDOUT.puts 'Role is out-of-sync. Updating ...'

#     # Members in AD but not RM (will be removed from AD)
#     (ad_members - role_members).each do |missing|
#       STDOUT.puts "\tRemoving from AD: #{missing}"
#       ActiveDirectoryHelper.ensure_user_not_in_group(missing, ad_group)
#     end

#     # Members in RM but not AD (will be added to AD)
#     (role_members - ad_members).each do |missing|
#       STDOUT.puts "\tAdding to AD: #{missing}"
#       begin
#         ActiveDirectoryHelper.ensure_user_in_group(missing, ad_group)
#       rescue ActiveDirectoryHelper::UserNotFound
#         STDOUT.puts "User '#{missing}' not found in AD while merging role and AD group"
#       rescue ActiveDirectoryHelper::GroupNotFound
#         STDOUT.puts "Group '#{ad_path}' not found in AD while merging role and AD group"
#       end
#     end
#   end

#   exit(0)
# else
#   abort "This script does not understand sync mode: #{@sync_data['mode']}"
# end

# # We will only get here on error.
# exit(1)
