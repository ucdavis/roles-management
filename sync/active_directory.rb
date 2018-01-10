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

begin
  @sync_data = JSON.parse(STDIN.read)
rescue JSON::ParserError
  abort 'JSON::ParserError: Input does not appear to be valid JSON.'
end

load "#{@sync_data["config_path"]}/../../lib/active_directory.rb"
load "#{@sync_data["config_path"]}/../../lib/active_directory_helper.rb"

@config = YAML.load_file(@sync_data["config_path"] + "/active_directory.yml")

ActiveDirectory.configure(@config)

case @sync_data['mode']

  when 'add_to_system'
    STDOUT.puts "Ensuring #{@sync_data['person']['loginid']} is in AD group dss-us-auto-all ..."
    if ActiveDirectoryHelper.ensure_user_in_group(@sync_data['person']['loginid'], 'dss-us-auto-all', nil) == false
      STDERR.puts "Error occurred while ensuring user '#{@sync_data['person']['loginid']}' was in group 'dss-us-auto-all'"
      exit(1)
    end
    STDOUT.puts 'Success!'
    # Note: the dss-us-auto-all group does not have a sentinel descriptor
    exit(0)

  when 'remove_from_system'
    STDOUT.puts "Ensuring #{@sync_data["person"]["loginid"]} is not in AD group dss-us-auto-all ..."
    if ActiveDirectoryHelper.ensure_user_not_in_group(@sync_data["person"]["loginid"], 'dss-us-auto-all', nil) == false
      STDERR.puts "Error occurred while ensuring user '#{@sync_data["person"]["loginid"]}' was not in group 'dss-us-auto-all'"
      exit(1)
    end
    STDOUT.puts 'Success!'
    # Note: the dss-us-auto-all group does not have a sentinel descriptor
    exit(0)

  when 'add_to_role'
    loginid = @sync_data['person']['loginid']
    ad_path = @sync_data['role']['ad_path']
    application_name = @sync_data['role']['application_name']
    role_name = @sync_data['role']['role_name']

    if ad_path.nil? || ad_path.empty?
      STDOUT.puts 'Ignoring remove_from_role: no ad_path given. (This is normal for any role without an AD path.)'
      exit(0)
    end

    # If ad_path and ad_guid are nil, return success (we don't respond to non-AD roles)
    STDOUT.puts "Adding #{loginid} to role represented in #{ad_path} ..."
    STDOUT.puts "Ensuring #{loginid} is in AD group #{ad_path} ..."
    if ActiveDirectoryHelper.ensure_user_in_group(loginid, ad_path) == false
      STDERR.puts "Error occurred while ensuring user '#{loginid}' was in group '#{ad_path}'"
      exit(1)
    end
    if ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(ad_path, application_name, role_name) == false
      STDERR.puts "Error occurred while updating AD group description for '#{ad_path}'"
      exit(1)
    end

    STDOUT.puts 'Success!'

    exit(0)

  when 'remove_from_role'
    ad_path = @sync_data['role']['ad_path']
    loginid = @sync_data['person']['loginid']
    application_name = @sync_data['role']['application_name']
    role_name = @sync_data['role']['role_name']

    if ad_path.nil? || ad_path.empty?
      STDOUT.puts 'Ignoring remove_from_role: no ad_path given. (This is normal for any role without an AD path.)'
      exit(0)
    end

    # If ad_path and ad_guid are nil, return success (we don't respond to non-AD roles)
    STDOUT.puts "Removing #{loginid} from role represented in #{ad_path} ..."
    STDOUT.puts "Ensuring #{loginid} is not in AD group #{ad_path} ..."
    if ActiveDirectoryHelper.ensure_user_not_in_group(loginid, ad_path) == false
      STDERR.puts "Error occurred while ensuring user '#{loginid}' was not in group '#{ad_path}'"
      exit(1)
    end
    if ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(ad_path, application_name, role_name) == false
      STDERR.puts "Error occurred while updating AD group description for '#{ad_path}'"
      exit(1)
    end

    STDOUT.puts 'Success!'

    exit(0)

  when 'add_to_organization'
    @sync_data['person']['affiliations'].each do |affiliation|
      # Write them to cluster-name-affiliation (dss-us-#{ou_to_short}-#{flatten_affiliation})
      short_ou = ActiveDirectoryHelper.ou_to_short(@sync_data['organization']['name'])
      flattened_affiliation = ActiveDirectoryHelper.flatten_affiliation(affiliation)

      # Skip unknown or ignored translations
      next if ((short_ou == false) || (flattened_affiliation == false) || (short_ou == nil) || (flattened_affiliation == nil))

      # Write them to cluster-affiliation-all
      cluster_affiliation_all_group_name = "dss-us-#{short_ou}-#{flattened_affiliation}".downcase
      STDOUT.puts "Ensuring #{@sync_data["person"]["loginid"]} is in AD group #{cluster_affiliation_all_group_name} ..."
      ActiveDirectoryHelper.ensure_user_in_group(@sync_data["person"]["loginid"], cluster_affiliation_all_group_name)
      ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(cluster_affiliation_all_group_name)

      # Write them to cluster-all (dss-us-#{ou_to_short}-all)
      cluster_all_group_name = "dss-us-#{short_ou}-all".downcase
      STDOUT.puts "Ensuring #{@sync_data["person"]["loginid"]} is in AD group #{cluster_all_group_name} ..."
      ActiveDirectoryHelper.ensure_user_in_group(@sync_data["person"]["loginid"], cluster_all_group_name)
      ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(cluster_all_group_name)
    end

    exit(0)

  when 'remove_from_organization'
    @sync_data['person']['affiliations'].each do |affiliation|
      # Remove them from cluster-name-affiliation (dss-us-#{ou_to_short}-#{flatten_affiliation})
      short_ou = ActiveDirectoryHelper.ou_to_short(@sync_data["organization"]["name"])
      flattened_affiliation = ActiveDirectoryHelper.flatten_affiliation(affiliation)

      # Skip unknown or ignored translations
      next if ((short_ou == false) || (flattened_affiliation == false) || (short_ou == nil) || (flattened_affiliation == nil))

      # Remove them from cluster-affiliation-all
      cluster_affiliation_all_group_name = "dss-us-#{short_ou}-#{flattened_affiliation}".downcase
      STDOUT.puts "Ensuring #{@sync_data["person"]["loginid"]} is not in AD group #{cluster_affiliation_all_group_name} ..."
      ActiveDirectoryHelper.ensure_user_not_in_group(@sync_data["person"]["loginid"], cluster_affiliation_all_group_name)
      ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(cluster_affiliation_all_group_name)

      # Remove them from cluster-all (dss-us-#{ou_to_short}-all)
      cluster_all_group_name = "dss-us-#{short_ou}-all".downcase
      STDOUT.puts "Ensuring #{@sync_data["person"]["loginid"]} is not in AD group #{cluster_all_group_name} ..."
      ActiveDirectoryHelper.ensure_user_not_in_group(@sync_data["person"]["loginid"], cluster_all_group_name)
      ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(cluster_all_group_name)
    end

    exit(0)

  when 'role_change'
    @sync_data['role']['changes'].each do |field, values|
      if field == 'ad_path'
        rm_client = RolesManagementAPI.login(@config['rm_endpoint']['host'], @config['rm_endpoint']['user'], @config['rm_endpoint']['pass'])
        abort('Could not connect to RM to merge role and AD group') unless rm_client.connected?

        old_value = values[0]
        new_value = values[1]

        # Clean up for a previous RM bug which erroneously created sync_jobs for
        # ad_path values changing from nil to "".
        old_value = nil if old_value.empty?
        new_value = nil if new_value.empty?
        exit(0) if old_value.nil? && new_value.nil?

        if (old_value == nil) && (new_value != nil)
          # AD path set for the first time. Merge role and AD group.
          ActiveDirectoryHelper.merge_role_and_ad_group(@sync_data['role']['id'], new_value, rm_client)
          ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(new_value, @sync_data['role']['application_name'], @sync_data['role']['role_name'])
        elsif (old_value != nil) && (new_value == nil)
          # AD path was set but is now unset. Leave all members but remove sentinel
          ActiveDirectoryHelper.ensure_sentinel_descriptor_absence(old_value)
        else
          # AD path went from one non-empty value to another non-empty value.
          # Leave the users in the first group (removing the sentinel) but
          # merge the second AD path with the role.
          ActiveDirectoryHelper.ensure_sentinel_descriptor_absence(old_value)

          ActiveDirectoryHelper.merge_role_and_ad_group(@sync_data['role']['id'], new_value, rm_client)
          ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(new_value, @sync_data['role']['application_name'], @sync_data['role']['role_name'])
        end
      end
    end

    exit(0)

  else
    abort "This script does not understand sync mode: #{@sync_data['mode']}"
end

# We will only get here on error.
exit(1)
