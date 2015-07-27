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

  def ActiveDirectory.update_group_description(group, description)
    unless group.is_a? Net::LDAP::Entry
      raise "Must pass valid group."
    end

    @ldap[:groups].each do |conn|
      if description and description.length > 0
        result = conn.modify(:dn => group[:distinguishedname][0], :operations => [
  				[ :replace, 'description', description ]
  			])
      else
        # Setting description to blank means we delete the description attribute
        result = conn.modify(:dn => group[:distinguishedname][0], :operations => [
  				[ :delete, 'description' ]
  			])
      end

      raise "LDAP error while updating description for #{group[:distinguishedname][0]}. Code: #{conn.get_operation_result.code }, Reason: #{conn.get_operation_result.message}" unless conn.get_operation_result.code == 0

      # result will be 'true' if user was successfully removed
      return result
    end

    STDERR.puts "Unable to update group description (#{group[:distinguishedname][0]})"

    return false
  end
end

# Adds the SENTINEL_DESCRIPTOR text to an AD group's description field if
# it is not present.
#
# +group+ is a Net::LDAP::Entry object or a string
# +application_name+ is an optional string of the application's name, if applicable
# +role_name+ is an optional string of the role's name, if applicable
def ensure_sentinel_descriptor_presence(group, application_name = nil, role_name = nil)
  unless group.is_a? Net::LDAP::Entry
    group = ActiveDirectory.get_group(group)
  end

  return false if group.nil?

  g_desc = group[:description][0]
  g_desc = "" if g_desc.nil?

  if(application_name and role_name)
    sentinel_txt = "(RM Sync: #{application_name} / #{role_name})"
  else
    sentinel_txt = "(RM Sync: Universal)"
  end

  # Remove the old-style sentinel if it exists
  if g_desc.index "(RM Sync)"
    g_desc.slice! "(RM Sync)"
    g_desc.lstrip!
  end

  # Ensure the sentinel exists
  unless g_desc.index sentinel_txt
    STDOUT.puts "Adding '#{sentinel_txt}' to AD group description."
    g_desc = "#{sentinel_txt} #{g_desc}"
    ActiveDirectory.update_group_description(group, g_desc)
  end
end

namespace :ad do
  desc 'Ensure the modern AD sentinel is in use'
  task :update_sentinels => :environment do
    @config = YAML.load_file(Rails.root.join('sync', 'config', 'active_directory.yml'))

    ActiveDirectory.configure(@config)

    Role.where('ad_path is not null').each do |role|
      ensure_sentinel_descriptor_presence(role.ad_path, role.application.name, role.name)
    end
  end
end
