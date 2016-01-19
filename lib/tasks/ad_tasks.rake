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

  desc 'Audit AD for membership differences in AD-enabled roles'
  task :audit_roles => :environment do
    @config = YAML.load_file(Rails.root.join('sync', 'config', 'active_directory.yml'))

    ActiveDirectory.configure(@config)

    # Audit each role
    ad_enabled_roles = Role.where('ad_path is not null')
    puts "Auditing #{ad_enabled_roles.count} AD-enabled roles ..."

    ad_enabled_roles.each do |role|
      print "Role (#{role.application.name} / #{role.name}) at '#{role.ad_path}' ... "
      ad_group = ActiveDirectory.get_group(role.ad_path)

      unless ad_group.is_a? Net::LDAP::Entry
        print "unknown. Could not retrieve #{role.ad_path} from AD. Skipping ...\n"
        next
      end

      ad_members = ActiveDirectory.list_group_members(ad_group)
      role_members = role.members.map{ |m| m.loginid }

      if(ad_members - role_members) == []
        print "fully synced.\n"
      else
        print "not fully synced:\n"
        puts "\tMissing from RM:"
        (ad_members - role_members).each do |missing|
          puts "\t\t#{missing}"
        end
        puts "\tMissing from AD:"
        (role_members - ad_members).each do |missing|
          puts "\t\t#{missing}"
        end
      end
    end
  end
end
