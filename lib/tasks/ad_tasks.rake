require 'json'
require 'yaml'
require 'net-ldap'
require 'roles-management-api'

load "#{Rails.root.join('lib', 'active_directory')}.rb"
load "#{Rails.root.join('lib', 'active_directory_helper')}.rb"

namespace :ad do
  desc 'Ensure the modern AD sentinel is in use'
  task :update_sentinels => :environment do
    @config = YAML.load_file(Rails.root.join('sync', 'config', 'active_directory.yml'))

    ActiveDirectory.configure(@config)

    # Ensure all roles are up-to-date
    Role.where('ad_path is not null').each do |role|
      ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(role.ad_path, role.application.name, role.name)
    end

    ous = ["IT", "HR", "CHP", "UCCS", "PHE", "HP", "SSP", "PHE", "RSC", "GEO", "ANT", "CMN", "ECN", "HIS", "LIN", "MSC", "PHI", "POL",
      "PSC", "EAS", "IRE", "MSA", "STS", "CMB", "SOC", "RED", "ORANGE", "BLUE", "GREEN", "DEANS", "YELLOW", "EDU", "ComDev", "NueroSci", "CSIS"]
    affiliations = ["faculty", "lecturer", "staff", "staff-student", "student-graduate"]

    ous.each do |ou|
      affiliations.each do |affiliation|
        cluster_affiliation_all_group_name = "dss-us-#{ou}-#{affiliation}".downcase
        ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(cluster_affiliation_all_group_name)
      end

      cluster_all_group_name = "dss-us-#{ou}-all".downcase
      ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(cluster_all_group_name)
    end
  end

  desc 'Audit AD for membership differences in AD-enabled roles (or role)'
  task :audit_roles, [:role_id] => :environment do |t, args|
    @config = YAML.load_file(Rails.root.join('sync', 'config', 'active_directory.yml'))

    ActiveDirectory.configure(@config)

    unless args[:role_id].nil?
      # Audit the specific role provided
      ad_enabled_roles = []
      ad_enabled_roles << Role.find(args[:role_id])
    else
      # Audit every AD-enabled role
      ad_enabled_roles = Role.where('ad_path is not null')
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
      role_members = role.members.select{|m| m.active == true}.map{ |m| m.loginid }

      if ad_members.sort == role_members.sort
        print "fully synced.\n"
      else
        num_out_of_sync_roles = num_out_of_sync_roles + 1
        print "not fully synced:\n"
        print "\tMembers in AD but not RM ("
        if ad_members.length > 0
          print ((ad_members - role_members).length.to_f / ad_members.length.to_f) * 100.0
        else
          print "100"
        end
        print "% different, should be deleted from AD):\n"
        (ad_members - role_members).each do |missing|
          puts "\t\t#{missing}"
        end
        print "\tMembers in RM but not AD ("
        if role_members.length > 0
          print ((role_members - ad_members).length.to_f / role_members.length.to_f) * 100.0
        else
          print "100"
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
  task :resync_roles, [:role_id] => :environment do |t, args|
    @config = YAML.load_file(Rails.root.join('sync', 'config', 'active_directory.yml'))

    ActiveDirectory.configure(@config)

    unless args[:role_id].nil?
      # Audit the specific role provided
      ad_enabled_roles = []
      ad_enabled_roles << Role.find(args[:role_id])
    else
      # Audit every AD-enabled role
      ad_enabled_roles = Role.where('ad_path is not null')
    end

    puts "Checking #{ad_enabled_roles.count} AD-enabled roles for re-syncing ..."

    num_out_of_sync_roles = 0

    ad_enabled_roles.each do |role|
      print "#{role.application.name} / #{role.name} -> #{role.ad_path} ... "
      ad_group = ActiveDirectory.get_group(role.ad_path)

      unless ad_group.is_a? Net::LDAP::Entry
        print "unknown. Could not retrieve #{role.ad_path} from AD. Skipping ...\n"
        next
      end

      ad_members = ActiveDirectory.list_group_members(ad_group)
      role_members = role.members.select{|m| m.active == true}.map{ |m| m.loginid }

      if ad_members.sort == role_members.sort
        print "fully synced.\n"
      else
        num_out_of_sync_roles = num_out_of_sync_roles + 1
        print "not fully synced:\n"

        puts "\tMembers in AD but not RM (will be removed from AD)"
        (ad_members - role_members).each do |missing|
          puts "\t\t#{missing} ..."
          ActiveDirectoryHelper.ensure_user_not_in_group(missing, ad_group)
        end

        puts "\tMembers in RM but not AD (will be added to AD)"
        (role_members - ad_members).each do |missing|
          puts "\t\t#{missing} ..."
          ActiveDirectoryHelper.ensure_user_in_group(missing, ad_group)
        end
      end
    end

    puts "Re-synced #{num_out_of_sync_roles} / #{ad_enabled_roles.count} AD-enabled role(s)."
  end

  desc 'Re-sync organization(s) to AD groups (destructive; optionally takes a single org ID)'
  task :resync_organizations, [:org_id] => :environment do |t, args|
    @config = YAML.load_file(Rails.root.join('sync', 'config', 'active_directory.yml'))

    ActiveDirectory.configure(@config)

    unless args[:org_id].nil?
      # Audit the specific org provided
      org = Organization.find_by_id(args[:org_id])
    else
      # Audit every org
      exit(1) # unsupported
    end

    # Since RM is authoritative on AD membership for these groups, we will merely
    # calculate what the group memberships should be and force AD to comply.

    # Create a list of all possible org + affiliation combinations
    # Check them for membership - add those who should be there, remove those who
    # shouldn't.
    # If an AD group doesn't exist, ignore it and move on.

    # Determine every possible AD group for this org
    short_ou = ActiveDirectoryHelper.ou_to_short(org.name)

    # Get all affiliations with mappings according to ActiveDirectoryHelper
    # Produces an array where each item is an array of ["flattened_afiliation_name", affiliation_id]

    # Reduce all affiliations to their "AD-flattened names" and compose a list of all IDs which share
    # the same flattened name
    affiliations = {}
    Affiliation.all.each do |a|
      flat_name = ActiveDirectoryHelper.flatten_affiliation( a.name )
      if flat_name.present?
        affiliations[flat_name] = [] if affiliations[flat_name].nil?
        affiliations[flat_name] << a.id
      end
    end

    # Handle the affiliation-based groups
    affiliations.each do |flat_name, affiliation_ids|
      # Determine all RM people who should be in this group
      ad_group = ActiveDirectory.get_group("dss-us-#{short_ou}-#{flat_name}".downcase)

      unless ad_group.is_a? Net::LDAP::Entry
        next
      end

      rm_people = Person.joins(:organizations).joins(:affiliations).where(:organizations => { id: org.id }).where(:affiliations => { id: affiliation_ids } ).where(:active => true).map{|p| p.loginid}.uniq
      ad_people = ActiveDirectory.list_group_members(ad_group).uniq

      puts "RM:"
      puts "\tAffiliation IDs      : #{affiliation_ids}"
      puts "\tAffiliation Flat Name: #{flat_name}"
      puts "\tPeople Count         : #{rm_people.length}"
      puts "\tPeople               : #{rm_people}"
      to_add = rm_people - ad_people
      puts "\tNeed adding          : #{to_add}"

      to_add.each do |loginid|
        ActiveDirectoryHelper.ensure_user_in_group(loginid, ad_group)
      end

      puts "\nAD (#{"dss-us-#{short_ou}-#{flat_name}".downcase}):"
      puts "\tPeople Count         : #{ad_people.length}"
      puts "\tPeople               : #{ad_people}"
      to_remove = ad_people - rm_people
      puts "\tNeed removing        : #{to_remove}"

      to_remove.each do |loginid|
        ActiveDirectoryHelper.ensure_user_not_in_group(loginid, ad_group)
      end

      puts "---"
    end

    # Handle the 'all' group
    ad_group = ActiveDirectory.get_group("dss-us-#{short_ou}-all".downcase)

    if ad_group.is_a? Net::LDAP::Entry
      rm_people = Person.joins(:organizations).joins(:affiliations).where(:organizations => { id: org.id }).where(:active => true).map{|p| p.loginid}.uniq
      ad_people = ActiveDirectory.list_group_members(ad_group).uniq

      puts "RM:"
      puts "\tPeople Count         : #{rm_people.length}"
      puts "\tPeople               : #{rm_people}"
      to_add = rm_people - ad_people
      puts "\tNeed adding          : #{to_add}"

      to_add.each do |loginid|
        ActiveDirectoryHelper.ensure_user_in_group(loginid, ad_group)
      end

      puts "\nAD (#{"dss-us-#{short_ou}-all".downcase}):"
      puts "\tPeople Count         : #{ad_people.length}"
      puts "\tPeople               : #{ad_people}"
      to_remove = ad_people - rm_people
      puts "\tNeed removing        : #{to_remove}"

      to_remove.each do |loginid|
        ActiveDirectoryHelper.ensure_user_not_in_group(loginid, ad_group)
      end

      puts "---"
    end



  end
end
