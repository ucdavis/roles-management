class ActiveDirectoryHelper
  class UserNotFound < StandardError; end
  class GroupNotFound < StandardError; end

  # Adds the SENTINEL_DESCRIPTOR text to an AD group's description field if
  # it is not present.
  #
  # +group+ is a Net::LDAP::Entry object or a string
  # +application_name+ is an optional string of the application's name, if applicable
  # +role_name+ is an optional string of the role's name, if applicable
  # @return true if description was present or added successfully to +group+
  def ActiveDirectoryHelper.ensure_sentinel_descriptor_presence(group, application_name = nil, role_name = nil)
    unless group.is_a? Net::LDAP::Entry
      group = ActiveDirectory.get_group(group)
      if group.nil?
        STDERR.puts 'ensure_sentinel_descriptor_presence failed: Cannot get_group().'
        return false
      end
    end

    g_desc = group[:description][0]
    g_desc = '' if g_desc.nil?

    if(application_name && role_name)
      sentinel_txt = "(RM Sync: #{application_name} / #{role_name})"
    else
      sentinel_txt = '(RM Sync: Universal)'
    end

    # Remove the old-style sentinel if it exists
    if g_desc.index '(RM Sync)'
      g_desc.slice! '(RM Sync)'
      g_desc.lstrip!
    end

    # Update sentinel only if it doesn't already exist
    unless g_desc.index sentinel_txt
      STDOUT.puts "Adding '#{sentinel_txt}' to AD group description."
      g_desc = "#{sentinel_txt} #{g_desc}"
      return ActiveDirectory.update_group_description(group, g_desc)
    end

    # Sentinel already existed
    return true # rubocop:disable Style/RedundantReturn
  end

  # Removes the SENTINEL_DESCRIPTOR text from an AD group's description field if
  # it is present.
  #
  # +group+ is a Net::LDAP::Entry object or a string
  # @return true if description was not present or removed successfully to +group+
  def ActiveDirectoryHelper.ensure_sentinel_descriptor_absence(group)
    unless group.is_a? Net::LDAP::Entry
      group = ActiveDirectory.get_group(group)
    end

    if group.nil?
      STDERR.puts 'ensure_sentinel_descriptor_absence failed: Cannot get_group().'
      return false
    end

    g_desc = group[:description][0]
    unless g_desc
      STDERR.puts 'ensure_sentinel_descriptor_absence failed: g_desc is nil.'
      return false
    end

    matches = /\(RM Sync[\s\S]*\)/.match(g_desc)

    if matches != nil
      STDOUT.puts "Removing '#{matches}' from AD group description."
      g_desc.sub! /\(RM Sync[\s\S]*\)/, ''
      g_desc.lstrip!
      return ActiveDirectory.update_group_description(group, g_desc)
    end

    return false # rubocop:disable Style/RedundantReturn
  end

  # +user+ must be a Person object
  # +group+ may be an AD path (string) or Net::LDAP::Entry object
  # optional ad_user
  def ActiveDirectoryHelper.ensure_user_in_group(user, group, ad_user = nil)
    unless user.is_a? Person
      raise ArgumentError, 'user parameter must be of type Person'
    end
    if group.is_a? Net::LDAP::Entry
      ad_path = group[:cn]
      ldap_group_object = group
    elsif group.is_a? String
      ad_path = group
      ldap_group_object = ActiveDirectory.get_group(group)
      raise GroupNotFound, 'Could not find group', caller if ldap_group_object.nil?
    else
      raise ArgumentError, 'group parameter must be of type Net::LDAP::Entry or String'
    end

    ldap_user_object = ad_user || ActiveDirectory.get_user(user.loginid)
    raise UserNotFound, 'Could not find user', caller if ldap_user_object.nil?

    # returns true or false
    ret = ActiveDirectory.add_user_to_group(ldap_user_object, ldap_group_object)

    if ret == true
      ActivityLog.info!("Added #{user.name} to AD group #{ad_path}.", ["person_#{user.id}", 'active_directory'])
    else
      ActivityLog.info!("Failed to add #{user.name} to AD group #{ad_path}.", ["person_#{user.id}", 'active_directory'])
    end

    return ret
  end

  # +user+ may a Person object or String
  # +group+ may be an AD path (string) or Net::LDAP::Entry object
  def ActiveDirectoryHelper.ensure_user_not_in_group(user, group)
    if user.is_a? Person
      ldap_user_object = ActiveDirectory.get_user(user.loginid)
      raise UserNotFound, 'Could not find user', caller if ldap_user_object.nil?
    elsif user.is_a? String
      # Assume the string is a login ID
      ldap_user_object = ActiveDirectory.get_user(user)
      raise UserNotFound, 'Could not find user', caller if ldap_user_object.nil?
    else
      raise ArgumentError, 'user parameter must be of type Person or String'
    end
    if group.is_a? Net::LDAP::Entry
      ad_path = group[:cn]
      ldap_group_object = group
    elsif group.is_a? String
      ad_path = group
      ldap_group_object = ActiveDirectory.get_group(group)
      raise GroupNotFound, 'Could not find group', caller if ldap_group_object.nil?
    else
      raise ArgumentError, 'group parameter must be of type Net::LDAP::Entry or String'
    end

    # returns true or false
    ret = ActiveDirectory.remove_user_from_group(ldap_user_object, ldap_group_object)

    if ret == true
      if user.is_a? Person
        ActivityLog.info!("Removed #{user.name} from AD group #{ad_path}.", ["person_#{user.id}", 'active_directory'])
      else
        ActivityLog.info!("Removed login ID #{user} from AD group #{ad_path}.", ['active_directory'])
      end
    end

    return ret
  end

  # Retrieves all members from both the role in RM and the AD group and ensures
  # both have the same members by adding any missing members from one to the other
  # (inclusively).
  def ActiveDirectoryHelper.merge_role_and_ad_group(role_id, group_name)
    ad_group = ActiveDirectory.get_group(group_name)

    unless ad_group.is_a? Net::LDAP::Entry
      abort("Could not retrieve AD group '#{group_name}'")
    end

    role = Role.find_by(id: role_id)

    # Add any role members to the AD group
    role.members.each do |member|
      STDOUT.puts "Ensuring #{member.loginid} is in AD group #{group_name} ..."
      begin
        ActiveDirectoryHelper.ensure_user_in_group(member, ad_group)
      rescue ActiveDirectoryHelper::UserNotFound
        STDERR.puts "User '#{member.loginid}' not found in AD while merging role and AD group"
      rescue ActiveDirectoryHelper::GroupNotFound
        STDERR.puts "Group '#{ad_path}' not found in AD while merging role and AD group"
      end
    end

    # Simple flag to avoid unnecessary RM activity
    role_changed = false

    # Add any AD group members to the role
    ActiveDirectory.list_group_members(ad_group).each do |ad_member|
      p = Person.find_by(loginid: ad_member)
      if p
        STDOUT.puts "Ensuring #{p.loginid} is in RM role #{role} ..."
        unless role.members.map(&:loginid).include? p.loginid
          role.assignments << p
          role_changed = true
        end
      else
        STDERR.puts "RM could not find AD member #{ad_member}. Unable to copy back into role."
      end
    end

    role.save if role_changed
  end
end
