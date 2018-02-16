require 'json'
require 'yaml'
require 'net-ldap'
require 'roles-management-api'

load "#{Rails.root.join('lib', 'active_directory')}.rb"
load "#{Rails.root.join('lib', 'active_directory_helper')}.rb"

namespace :ad do
  desc 'Audit AD for membership differences in AD-enabled roles (or role)'
  task :audit_roles, [:role_id] => :environment do |t, args|
    @config = YAML.load_file(Rails.root.join('sync', 'config', 'active_directory.yml'))

    ActiveDirectory.configure(@config)

    if args[:role_id].nil?
      # Audit every AD-enabled role
      ad_enabled_roles = Role.where('ad_path is not null')
    else
      # Audit the specific role provided
      ad_enabled_roles = []
      ad_enabled_roles << Role.find(args[:role_id])
    end

    puts "Auditing #{ad_enabled_roles.count} AD-enabled roles ..."

    num_out_of_sync_roles = 0

    ad_enabled_roles.each do |role|
      print "#{role.application.name} / ##{role.id} #{role.name} -> #{role.ad_path} ... "
      ad_group = ActiveDirectory.get_group(role.ad_path)

      unless ad_group.is_a? Net::LDAP::Entry
        print "unknown. Could not retrieve #{role.ad_path} from AD. Skipping ...\n"
        next
      end

      ad_members = ActiveDirectory.list_group_members(ad_group)
      role_members = role.members.select { |m| m.active == true }.map(&:loginid)

      if ad_members.sort == role_members.sort
        print "fully synced.\n"
      else
        num_out_of_sync_roles += 1
        print "not fully synced:\n"
        print "\tMembers in AD but not RM ("
        if ad_members.length > 0
          print((ad_members - role_members).length.to_f / ad_members.length.to_f) * 100.0
        else
          print '100'
        end
        print "% different, should be deleted from AD):\n"
        (ad_members - role_members).each do |missing|
          puts "\t\t#{missing}"
        end
        print "\tMembers in RM but not AD ("
        if role_members.length > 0
          print ((role_members - ad_members).length.to_f / role_members.length.to_f) * 100.0
        else
          print '100'
        end
        print "% different, should be added to AD):\n"
        (role_members - ad_members).each do |missing|
          puts "\t\t#{missing}"
        end
      end
    end

    puts "Found #{num_out_of_sync_roles} / #{ad_enabled_roles.count} AD-enabled role(s) in need of syncing."
  end

  desc 'Re-sync role(s) to AD groups (destructive; optionally takes a single role ID)'
  task :resync_roles, [:role_id] => :environment do |_t, args|
    @config = YAML.load_file(Rails.root.join('sync', 'config', 'active_directory.yml'))

    ActiveDirectory.configure(@config)

    if args[:role_id].nil?
      # Audit every AD-enabled role
      ad_enabled_roles = Role.where('ad_path is not null')
    else
      # Audit the specific role provided
      ad_enabled_roles = []
      ad_enabled_roles << Role.find(args[:role_id])
    end

    # puts "Checking #{ad_enabled_roles.count} AD-enabled roles for re-syncing ..."

    num_out_of_sync_roles = 0

    ad_enabled_roles.each do |role|
      # print "#{role.application.name} / #{role.name} -> #{role.ad_path} ... "
      ad_group = ActiveDirectory.get_group(role.ad_path)

      unless ad_group.is_a? Net::LDAP::Entry
        print "Error syncing #{role.application.name} / #{role.name}. Could not retrieve '#{role.ad_path}' from AD. Skipping ...\n"
        next
      end

      ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(ad_group, role.application.name, role.name)

      ad_members = ActiveDirectory.list_group_members(ad_group)
      role_members = role.members.select { |m| m.active == true }.map(&:loginid)

      if ad_members.sort == role_members.sort
        # print "fully synced.\n"
      else
        num_out_of_sync_roles += 1
        # puts "Found out-of-sync, will re-sync: #{role.application.name} / #{role.name} -> #{role.ad_path}"
        # print "not fully synced:\n"

        # puts "\tMembers in AD but not RM (will be removed from AD)"
        (ad_members - role_members).each do |missing|
          # puts "\t\t#{missing} ..."
          ActiveDirectoryHelper.ensure_user_not_in_group(missing, ad_group)
        end

        # puts "\tMembers in RM but not AD (will be added to AD)"
        (role_members - ad_members).each do |missing|
          # puts "\t\t#{missing} ..."
          begin
            retries ||= 0
            ActiveDirectoryHelper.ensure_user_in_group(missing, ad_group)
          rescue ActiveDirectoryHelper::UserNotFound
            # STDERR.puts "User '#{missing}' not found in AD while merging role and AD group"
          rescue ActiveDirectoryHelper::GroupNotFound
            # STDERR.puts "Group '#{ad_path}' not found in AD while merging role and AD group"
          rescue Net::LDAP::Error
            STDERR.puts "LDAP connection timeout while ensuring user #{missing} is in group #{ad_group}"
            retry if (retries += 1) < 3
          end
        end
      end
    end

    # puts "Re-synced #{num_out_of_sync_roles} / #{ad_enabled_roles.count} AD-enabled role(s)."
  end

  desc 'Audit AD for differences between a group and an AD path'
  task :audit_group_with_path, [:group_id, :ad_path] => :environment do |t, args|
    STDERR.puts 'Must supply a group ID' if args[:group_id].nil?
    STDERR.puts 'Must supply an AD path' if args[:ad_path].nil?

    @config = YAML.load_file(Rails.root.join('sync', 'config', 'active_directory.yml'))

    ActiveDirectory.configure(@config)

    group = Group.find_by(id: args[:group_id])
    if group.nil?
      STDERR.puts "Could not find Group with ID #{args[:group_id]}"
      exit(-1)
    end

    ad_group = ActiveDirectory.get_group(args[:ad_path])

    unless ad_group.is_a? Net::LDAP::Entry
      STDERR.puts "Could not find AD path #{args[:ad_path]}"
      exit(-1)
    end

    ad_members = ActiveDirectory.list_group_members(ad_group)
    group_members = group.members.select { |m| m.active == true }.map(&:loginid)

    if ad_members.sort == group_members.sort
      puts 'No differences found.'
    else
      puts 'Differences found:'
      print "\tMembers in AD but not RM ("
      if ad_members.length > 0
        print (((ad_members - group_members).length.to_f / ad_members.length.to_f) * 100.0).round(2)
      else
        print '100'
      end
      print "% different, should be deleted from AD):\n"
      (ad_members - group_members).each do |missing|
        puts "\t\t#{missing}"
      end
      print "\tMembers in RM but not AD ("
      if group_members.length > 0
        print (((group_members - ad_members).length.to_f / group_members.length.to_f) * 100.0).round(2)
      else
        print '100'
      end
      print "% different, should be added to AD):\n"
      (group_members - ad_members).each do |missing|
        puts "\t\t#{missing}"
      end
    end
  end
end
