require 'net-ldap'

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
        :encryption => { :method => :simple_tls },
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
        :encryption => { :method => :simple_tls },
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

  # Returns an array of login IDs for the group's members, if any, if possible
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
