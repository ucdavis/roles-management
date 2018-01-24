require 'roles-management-api'

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

  # +user+ may be a loginid (string) or Net::LDAP::Entry object
  # +group+ may be an AD path (string) or Net::LDAP::Entry object
  # +ad_guid+ may be provided (optional) and will be preferred over AD Path if
  # +group+ is a string (AD Path)
  def ActiveDirectoryHelper.ensure_user_in_group(user, group, _ad_guid = nil)
    unless user.is_a? Net::LDAP::Entry
      loginid = user
      user = ActiveDirectory.get_user(loginid)
      if user.nil?
        STDERR.puts "ensure_user_in_group failed: could not find user '#{loginid}' in AD"
        return false
      end
    end
    unless group.is_a? Net::LDAP::Entry
      group_name = group
      group = ActiveDirectory.get_group(group_name)
      if group.nil?
        STDERR.puts "ensure_user_in_group failed: could not find group '#{group_name}' in AD"
        return false
      end
    end

    # returns true or false
    ActiveDirectory.add_user_to_group(user, group)
  end

  # User may be a loginid (string) or Net::LDAP::Entry object
  # Group may be an AD path (string) or Net::LDAP::Entry object
  # ad_guid may be provided (optional) and will be prefered over AD Path if
  # 'group' is a string (AD Path)
  def ActiveDirectoryHelper.ensure_user_not_in_group(user, group, _ad_guid = nil)
    unless user.is_a? Net::LDAP::Entry
      user = ActiveDirectory.get_user(user)
      raise UserNotFound, 'No such user found', caller if user.nil?
    end
    unless group.is_a? Net::LDAP::Entry
      group = ActiveDirectory.get_group(group)
      raise GroupNotFound, 'No such group found', caller if group.nil?
    end

    # returns true or false
    ActiveDirectory.remove_user_from_group(user, group)
  end

  # Retrieves all members from both the role in RM and the AD group and ensures
  # both have the same members by adding any missing members from one to the other
  # (inclusively).
  def ActiveDirectoryHelper.merge_role_and_ad_group(role_id, group_name, rm_client)
    ad_group = ActiveDirectory.get_group(group_name)

    unless ad_group.is_a? Net::LDAP::Entry
      abort("Could not retrieve AD group '#{group_name}'")
    end

    role = rm_client.find_role_by_id(role_id)

    # Add any role members to the AD group
    role.members.each do |member|
      STDOUT.puts "Ensuring #{member.loginid} is in AD group #{group_name} ..."
      ActiveDirectoryHelper.ensure_user_in_group(member.loginid, ad_group)
    end

    # Simple flag to avoid unnecessary RM activity
    role_changed = false

    # Add any AD group members to the role
    ActiveDirectory.list_group_members(ad_group).each do |ad_member|
      p = rm_client.find_person_by_loginid(ad_member)
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

    rm_client.save(role) if role_changed
  end
end
