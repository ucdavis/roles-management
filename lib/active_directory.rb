require 'net-ldap'

class ActiveDirectory
  class LdapError < StandardError; end
  class InvalidParameter < StandardError; end
  class OperationFailed < StandardError; end

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

      begin
        conn = Net::LDAP.new(server)
        conn.bind
      rescue Net::LDAP::Error
        raise LdapError, "Error while connecting to server #{server[:host]}.", caller
      end

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

      begin
        conn = Net::LDAP.new(server)
        conn.bind
      rescue Net::LDAP::Error
        raise LdapError, "Error while connecting to server #{server[:host]}.", caller
      end

      @ldap[:groups] << conn
    end
  end

  def ActiveDirectory.get_user(loginid)
    @ldap[:people].each do |conn|
      result = conn.search(filter: Net::LDAP::Filter.eq('sAMAccountName', loginid))
      raise LdapError, "Error while fetching user #{loginid}. Code: #{conn.get_operation_result.code }, Reason: #{conn.get_operation_result.message}", caller unless conn.get_operation_result.code == 0

      if result.length > 0
        return result[0]
      end
    end

    return nil
  end

  def ActiveDirectory.get_group(group_name)
    @ldap[:groups].each do |conn|
      result = conn.search(filter: Net::LDAP::Filter.eq('cn', group_name))
      raise LdapError, "Error while fetching group #{group_name}. Code: #{conn.get_operation_result.code }, Reason: #{conn.get_operation_result.message}", caller unless conn.get_operation_result.code == 0

      if result.length > 0
        return result[0]
      end
    end

    return nil
  end

  # Adds +user+ to +group+
  #
  # @return true if +user+ is added to +group+ or +user+ is already in +group+, else false.
  # @raise [InvalidParameter] if +user+ or +group+ are not of type Net::LDAP::Entry
  # @raise [LdapError] if LDAP operation result code is non-zero
  def ActiveDirectory.add_user_to_group(user, group)
    unless user.is_a? Net::LDAP::Entry
      raise InvalidParameter, 'Must pass valid user', caller
    end
    unless group.is_a? Net::LDAP::Entry
      raise InvalidParameter, 'Must pass valid group', caller
    end

    unless Rails.env.production?
      Rails.logger.warn 'ActiveDirectory.add_user_to_group() will no-op outside of production but return success.'
      return true
    end

    # TODO: This will only process against the first entry in @ldap[:groups]
    @ldap[:groups].each do |conn|
      result = conn.modify(dn: group[:distinguishedname][0], operations: [
        [ :add, :member, user[:distinguishedname][0] ]
      ])

      if conn.get_operation_result.code == LDAP_ALREADY_EXISTS
        return true # user was already in this group
      end

      raise LdapError, "Error while adding user (#{user[:distinguishedname][0]}) to group (#{group[:distinguishedname][0]}). Code: #{conn.get_operation_result.code }, Reason: #{conn.get_operation_result.message}", caller unless conn.get_operation_result.code == 0

      # result will be 'true' if user was successfully added
      return result
    end

    return false
  end

  # Removes +user+ from +group+.
  #
  # @return true if +user+ was removed from +group+ or +user+ was already not in +group+
  # @raise [InvalidParameter] if +user+ or +group+ are not of type Net::LDAP::Entry
  # @raise [LdapError] if an LDAP error occurs
  def ActiveDirectory.remove_user_from_group(user, group)
    unless user.is_a? Net::LDAP::Entry
      raise InvalidParameter, 'Must pass valid user', caller
    end
    unless group.is_a? Net::LDAP::Entry
      raise InvalidParameter, 'Must pass valid group', caller
    end

    unless Rails.env.production?
      Rails.logger.warn 'ActiveDirectory.remove_user_from_group() will no-op outside of production but return success.'
      return true
    end

    # TODO: This will only process against the first entry in @ldap[:groups]
    @ldap[:groups].each do |conn|
      result = conn.modify(dn: group[:distinguishedname][0], operations: [
        [ :delete, :member, user[:distinguishedname][0] ]
      ])

      if conn.get_operation_result.code == LDAP_UNWILLING_TO_PERFORM
        return true # user was already not in the group
      end

      raise LdapError, "Error while removing user (#{user[:distinguishedname][0]}) from group (#{group[:distinguishedname][0]}). Code: #{conn.get_operation_result.code }, Reason: #{conn.get_operation_result.message}", caller unless conn.get_operation_result.code == 0

      # result will be 'true' if user was successfully removed
      return result
    end

    return false
  end

  # @return true if group described was updated
  # @raise [InvalidParameter] if +group+ is not of type Net::LDAP::Entry
  # @raise [LdapError] if an LDAP error occurred
  def ActiveDirectory.update_group_description(group, description)
    unless group.is_a? Net::LDAP::Entry
      raise InvalidParameter, 'Must pass valid group', caller
    end

    unless Rails.env.production?
      Rails.logger.warn 'ActiveDirectory.update_group_description() will no-op outside of production but return success.'
      return true
    end

    @ldap[:groups].each do |conn|
      if description and description.length > 0
        result = conn.modify(dn: group[:distinguishedname][0], operations: [
          [ :replace, 'description', description ]
        ])
      else
        # Setting description to blank means we delete the description attribute
        result = conn.modify(dn: group[:distinguishedname][0], operations: [
          [ :delete, 'description' ]
        ])
      end

      raise LdapError, "Error while updating description for #{group[:distinguishedname][0]}. Code: #{conn.get_operation_result.code }, Reason: #{conn.get_operation_result.message}", caller unless conn.get_operation_result.code == 0

      # result will be 'true' if description was successfully updated
      return result
    end

    return false
  end

  # Returns an array of login IDs for members of +group+, if any, if possible
  # This function purposefully ignores UCD's OU-based members, e.g. DC=ou
  # @param group String or Net::LDAP::Entry representing the desired group
  # @return [Array] the login IDs of the members in +group+
  def ActiveDirectory.list_group_members(group)
    group_name = nil

    if group.is_a? Net::LDAP::Entry
      group_name = group[:samaccountname][0]
    else
      group_name = group
    end

    if group_name.nil? || group_name.length == 0
      raise OperationFailed, 'Group not found', caller
      return nil
    end

    # Credit: https://github.com/ruby-ldap/ruby-net-ldap/issues/208
    range_regex    = /member;range=\d+-(\d+|\*)/ # member;range=0-1499, member;range=1500-*
    remote_members = []
    start          = 0
    match          = nil
    loop do
      entry = nil

      @ldap[:groups].each do |conn|
        result = conn.search(
          filter:     Net::LDAP::Filter.eq('sAMAccountName', group_name),
          attributes: "member;range=#{start}-*"
        )
        raise LdapError, "Error while fetching group #{group_name}. Code: #{conn.get_operation_result.code }, Reason: #{conn.get_operation_result.message}", caller unless conn.get_operation_result.code == 0

        if result.length > 0
          entry = result[0]
          break
        end
      end

      return [] if entry.nil?

      range = entry.attribute_names.map(&:to_s).find { |attr| match = attr.match range_regex }
      break unless range
      #puts "Found range: #{range}"
      remote_members.concat entry[range]
      #puts "Added #{entry[range].size}"
      #puts "Duplicates: #{remote_members.size - remote_members.uniq.size}"
      stop = match[1]
      break if stop == '*' # Halt if we're at the end of the records: member;range=1500-*
      start = stop.to_i + 1
    end

    members = []

    # Map remote_members LDAP names to simple login IDs
    remote_members.each do |member|
      # Ignore DC=ou members
      if member.scan(/DC=ou/i).length == 0
        members << member.match(/CN=([^,]+),/).captures[0]
      end
    end

    return members
  end
end
