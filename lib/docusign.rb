# One time setup of user consent for jwt user token required -  https://www.docusign.com/blog/developers/oauth-jwt-granting-consent
# add redirect_uri to App and Keys settings
# https://account-d.docusign.com/oauth/auth?response_type=code&scope=signature%20impersonation&client_id={CLIENT_ID}&redirect_uri={REDIRECT_URI}

require "docusign_esign"
require "base64"

module Docusign
  # NEW USER DEFAULTS
  DEFAULT_PERMISSION_PROFILE = ENV["DS_DEFAULT_PERMISSION_PROFILE"] # "UC Davis Power User"
  ADMIN_PROFILE_NAME = "Account Administrator"
  DEFAULT_ADDRESS = {
    address1: "One Shields Ave",
    city: "Davis",
    stateOrProvince: "CA",
    postalCode: "95616",
    country: "United States",
  }

  class DocuSign_eSign::ApiError
    def detailed_message
      response_body = JSON.parse(self.response_body)
      "Error:\n#{self.code} #{self.message}\n#{response_body["errorCode"]}: #{response_body["message"]}"
    end
  end

  def self.configure
    @api_account_id = ENV["DS_API_ACCOUNT_ID"]
    client_id = ENV["DS_CLIENT_ID"] # Integration Key
    user_id = ENV["DS_USER_ID"]
    private_key = Base64.decode64(ENV["DS_PRIVATE_KEY_64"])
    expires_in = 3600

    @configuration = DocuSign_eSign::Configuration.new
    @configuration.host = ENV["DS_HOST_NAME"]

    @api_client = DocuSign_eSign::ApiClient.new(@configuration)
    @api_client.set_oauth_base_path ENV["DS_OAUTH_BASE_PATH"]

    @token = @api_client.request_jwt_user_token(client_id, user_id, private_key, expires_in)

    @api_client.set_default_header("Authorization", "Bearer #{@token.access_token}")

    @users_api = DocuSign_eSign::UsersApi.new(@api_client)
    @groups_api = DocuSign_eSign::GroupsApi.new(@api_client)
    @signing_groups_api = DocuSign_eSign::SigningGroupsApi.new(@api_client)
    @accounts_api = DocuSign_eSign::AccountsApi.new(@api_client) # for permission profiles

    @token.present?
  end

  # query for base path from UserInfo
  #   user_info = @api_client.get_user_info(@token.access_token)
  #   base_uri = user_info.accounts.first.base_uri
  #   @api_client.set_base_path(base_uri)

  def self.find_user_by_email(email)
    # API only returns active users by default (not pending/activationSent)
    # if not found, try again with {status: "ActivationSent"}
    begin
      list_options = DocuSign_eSign::ListOptions.new
      list_options.email = email
      users_list = @users_api.list(@api_account_id, list_options)
    rescue DocuSign_eSign::ApiError => e
      puts "Could not find #{email} among Active users. Retrying for pending users"
    end

    if users_list.nil?
      list_options.status = "ActivationSent"
      begin
        users_list = @users_api.list(@api_account_id, list_options)
      rescue => exception
        puts "User #{email} not found"
        return nil
      end
    end

    return users_list.users.first
  end

  # DocuSign email value should be AD::UPN because it uses ADFS for SSO
  def self.create_user(name, email)
    new_users_definition = DocuSign_eSign::NewUsersDefinition.new({
      newUsers: [{
        userName: name,
        email: email,
        permissionProfileId: DEFAULT_PERMISSION_PROFILE,
        workAddress: DEFAULT_ADDRESS,
      }],
    })

    # limits to 500 users at a time
    @users_api.create(@api_account_id, new_users_definition).new_users.first
  end

  def self.update_user(user, options)
    @users_api.update_user(@api_account_id, user.user_id, user_information)
  end

  # The Administrators group is handled via Permission Profiles
  def self.assign_admin(ds_user)
    admin_profile_id = self.get_admin_permission_profile.permission_profile_id
    user_info = DocuSign_eSign::UserInformation.new({ permissionProfileId: admin_profile_id })
    @users_api.update_user(@api_account_id, ds_user.user_id, user_info)
  end

  def self.revoke_admin(ds_user)
    user_info = DocuSign_eSign::UserInformation.new({ permissionProfileId: DEFAULT_PERMISSION_PROFILE })
    @users_api.update_user(@api_account_id, ds_user.user_id, user_info)
  end

  def self.find_or_create_user(user)
    ds_user = find_user_by_email(user[:email])

    if ds_user
      return ds_user
    else
      return self.create_user(user[:name], user[:email])
    end
  end

  def self.delete_user(email)
    user = self.find_user_by_email(email)
    user_info_list = DocuSign_eSign::UserInfoList.new({ users: [{ accountId: @api_account_id, userId: user.user_id }] })

    @users_api.delete(@api_account_id, user_info_list)
  end

  # Groups (Anthro, Art, Chemistry, etc...), ignore "Administrators", "Everyone" which are handled via Permission Profiles
  def self.get_groups
    ignored_groups = ["Everyone"]
    @groups_api.list_groups(@api_account_id).groups.filter { |g| ignored_groups.exclude? g.group_name }
  end

  def self.find_group_by_id(group_id)
    list_groups_options = DocuSign_eSign::ListGroupsOptions.new
    response = @groups_api.list_groups(@api_account_id, list_groups_options)
    response.groups.filter { |g| g.group_id == group_id.to_s }.first
  end

  def self.find_group_by_name(group_name)
    list_groups_options = DocuSign_eSign::ListGroupsOptions.new
    list_groups_options.search_text = group_name

    @groups_api.list_groups(@api_account_id, list_groups_options).groups.first
  end

  # @param [Array<String>] group_names
  def self.create_groups(group_names)
    ds_groups = group_names.map { |name| DocuSign_eSign::Group.new({ groupName: name }) }
    group_information = DocuSign_eSign::GroupInformation.new({ groups: ds_groups })

    @groups_api.create_groups(@api_account_id, group_information)
  end

  def self.update_group(group_id, new_name)
    ds_group = self.find_group_by_id(group_id)
    ds_group.group_name = new_name
    group_information = DocuSign_eSign::GroupInformation.new({ groups: Array(ds_group) })
    @groups_api.update_groups(@api_account_id, group_information)
  end

  def self.delete_group(group_name)
    ds_group = self.find_group_by_name(group_name)
    group_information = DocuSign_eSign::GroupInformation.new({ groups: Array(ds_group) })
    @groups_api.delete_groups(@api_account_id, group_information)
  end

  def self.delete_group_by_id(group_id)
    ds_group = self.find_group_by_id(group_id)
    group_information = DocuSign_eSign::GroupInformation.new({ groups: Array(ds_group) })
    @groups_api.delete_groups(@api_account_id, group_information)
  end

  def self.delete_groups(ds_groups)
    # ds_groups = ds_groups.map { |name| DocuSign_eSign::Group.new({ groupId: group_id groupName: group_name }) }
    group_information = DocuSign_eSign::GroupInformation.new({ groups: ds_groups })

    @groups_api.delete_groups(@api_account_id, group_information)
  end

  def self.get_group_users(ds_group)
    # user with DS Admin profile will show up in the Administrators group even if closed, filter them out for our purposes
    @groups_api.list_group_users(@api_account_id, ds_group.group_id).users.select { |u| u.user_status != "closed" }
  end

  def self.add_users_to_group(users, group)
    if group.group_name == "Administrators"
      users.each do |user|
        self.assign_admin(user)
      end
    else
      user_info_list = DocuSign_eSign::UserInfoList.new({ users: users })
      @groups_api.update_group_users(@api_account_id, group.group_id, user_info_list)
    end
  end

  def self.remove_users_from_group(users, group)
    if group.group_name == "Administrators"
      users.each do |user|
        self.revoke_admin(user)
      end
    else
      user_info_list = DocuSign_eSign::UserInfoList.new({ users: users })
      @groups_api.delete_group_users(@api_account_id, group.group_id, user_info_list)
    end
  end

  # Signing Groups (LS VRA Team, Lab, etc...)
  def self.get_signing_groups
    @signing_groups_api.list(@api_account_id)
  end

  # Permission Profiles (Sender, Power User, Admin, etc...)
  def self.get_permission_profiles
    @accounts_api.list_permissions(@api_account_id).permission_profiles
  end

  def self.get_admin_permission_profile
    self.get_permission_profiles.find { |profile| profile.permission_profile_name == ADMIN_PROFILE_NAME }
  end

  # used by sync_script_job.rb
  def self.add_person_to_group(person, group_name)
    ds_user = self.find_or_create_user({ name: person.name, email: person.ad_upn })
    # person.docusign_id = ds_user.user_id
    # person.save! if person.changed?
    ds_group = self.find_group_by_name(group_name)

    self.add_users_to_group(Array(ds_user), ds_group)
  end

  # used by sync_script_job.rb
  def self.remove_person_from_group(person, group_name)
    # byebug
    ds_user = self.find_or_create_user({ name: person.name, email: person.ad_upn })
    ds_group = self.find_group_by_name(group_name)

    self.remove_users_from_group(Array(ds_user), ds_group)
  end

  # Helper Methods
  def self.tokenize(group_name)
    "ds-" + group_name.gsub(/\s/, "-").downcase
  end

  # Compares DocuSign users and Roles entities using proxy addresses due to possible UPN update
  # returns array of first argument type
  def self.diff_users(arr1, arr2)
    ds_users_first = arr1.first.is_a? DocuSign_eSign::UserInfo

    if ds_users_first
      arr1.select.each { |ds_user|
        arr2.none? { |role_member| role_member.ad_proxy_addresses.include? ds_user.email.downcase }
      }
    else
      arr1.select.each { |role_member|
        arr2.none? { |ds_user| role_member.ad_proxy_addresses.include? ds_user.email.downcase }
      }
    end
  end
end
