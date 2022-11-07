# One time setup of user consent for jwt user token required -  https://www.docusign.com/blog/developers/oauth-jwt-granting-consent
# add redirect_uri to App and Keys settings
# https://account-d.docusign.com/oauth/auth?response_type=code&scope=signature%20impersonation&client_id={CLIENT_ID}&redirect_uri={REDIRECT_URI}

require "docusign_esign"
require "base64"

module Docusign
  # NEW USER DEFAULTS
  # DEFAULT_PERMISSION_PROFILE = 16927505 # PROD UC Davis Power User
  DEFAULT_PERMISSION_PROFILE = 13769603 # SANDBOX UC Davis Power User
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

  def self.find_or_create_user(user)
    ds_user = find_user_by_email(user[:email])

    if ds_user
      return ds_user
    else
      return self.create_user(user[:name], user[:email])
    end
  end

  def self.delete_user(email)
    user_id = self.find_user_id_by_email(email)
    user_info_list = DocuSign_eSign::UserInfoList.new({ users: [{ accountId: @api_account_id, userId: user_id }] })

    @users_api.delete(@api_account_id, user_info_list)
  end

  # Groups (Anthro, Art, Chemistry, etc...), ignore "Everyone" for our purposes
  def self.get_groups
    @groups_api.list_groups(@api_account_id).groups.filter { |g| g.group_name != "Everyone" }
  end

  def self.find_group_by_name(group_name)
    list_groups_options = DocuSign_eSign::ListGroupsOptions.new
    list_groups_options.search_text = group_name

    @groups_api.list_groups(@api_account_id, list_groups_options).groups.first
  end

  # @params [Array<String>] group_names
  def self.create_groups(group_names)
    ds_groups = group_names.map { |name| DocuSign_eSign::Group.new({ groupName: name }) }
    group_information = DocuSign_eSign::GroupInformation.new({ groups: ds_groups })

    @groups_api.create_groups(@api_account_id, group_information)
  end

  def self.delete_group
  end

  def self.get_group_users(ds_group)
    @groups_api.list_group_users(@api_account_id, ds_group.group_id).users
  end

  def self.add_users_to_group(users, group)
    user_info_list = DocuSign_eSign::UserInfoList.new({ users: users })

    @groups_api.update_group_users(@api_account_id, group.group_id, user_info_list)
  end

  def self.remove_users_from_group(users, group)
    user_info_list = DocuSign_eSign::UserInfoList.new({ users: users })

    @groups_api.delete_group_users(@api_account_id, group.group_id, user_info_list)
  end

  # Signing Groups (LS VRA Team, Lab, etc...)
  def self.get_signing_groups
    @signing_groups_api.list(@api_account_id)
  end

  # Permission Profiles (Sender, Power User, Admin, etc...)
  def self.get_permission_profiles
    @accounts_api.list_permissions(@api_account_id).permission_profiles
  end

  # Single sync script jobs
  def self.add_person_to_group(person, group_name)
    ds_user = self.find_or_create_user({ name: person.name, email: person.email })
    ds_group = self.find_group_by_name(group_name)

    self.add_users_to_group(Array(ds_user), ds_group)
  end

  def self.remove_person_from_group(person, group_name)
    # byebug
    ds_user = self.find_or_create_user({ name: person.name, email: person.email })
    ds_group = self.find_group_by_name(group_name)

    self.remove_users_from_group(Array(ds_user), ds_group)
  end

  # Helper Methods
  def self.tokenize(group_name)
    "ds-" + group_name.gsub(/\s/, "-").downcase
  end

  # Compares DocuSign users and Roles People by email OR first and last
  # returns array of first argument type
  def self.diff_users(arr1, arr2)
    ds_users_first = arr1.first.respond_to? "user_name"

    if ds_users_first
      arr1.select.each { |ds_user|
        arr2.none? { |role_member| ds_user.email == role_member.email || "#{role_member.first} #{role_member.last}" == ds_user.user_name }
      }
    else
      arr1.select.each { |role_member|
        arr2.none? { |ds_user| ds_user.email == role_member.email || "#{role_member.first} #{role_member.last}" == ds_user.user_name }
      }
    end
  end
end
