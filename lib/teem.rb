module Teem
  require 'net/http'
  require 'json'

  CLIENT_ID = ENV['TEEM_CLIENT_ID']
  CLIENT_SECRET = ENV['TEEM_CLIENT_SECRET']
  REFRESH_TOKEN = ENV['TEEM_REFRESH_TOKEN']
  REDIRECT_URI = ENV['TEEM_REDIRECT_URI']
  USERNAME = ENV['TEEM_USERNAME']
  PASSWORD = ENV['TEEM_PASSWORD']
  ORG_NAME = ENV['TEEM_ORG_NAME']

  def self.request(methods, access_token, url, json_obj = nil)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.verify_mode = OpenSSL::SSL::VERIFY_NONE

    if methods == :get
      request = Net::HTTP::Get.new(uri.request_uri)
    elsif methods == :post
      request = Net::HTTP::Post.new(uri.request_uri)
    elsif methods == :patch
      request = Net::HTTP::Patch.new(uri.path)
    elsif methods == :delete
      request = Net::HTTP::Delete.new(uri.request_uri)
    end

    if access_token
      request.add_field('Authorization', "Bearer #{access_token}")
    end

    if json_obj
      request.add_field('Content-Type', 'application/json')
      request.body = json_obj
    end

    retries = 0
    success = false
    while (retries < 5) && (success == false)
      begin
        response = http.request(request)
        success = true
      rescue Net::ReadTimeout
        retries += 1
      end
    end

    if success == false
      STDERR.puts 'Unable to complete HTTP request. Giving up ...'
      return nil
    end

    return response.body ? JSON.parse(response.body) : nil
  end

  # Authorizes against the Teem API. Required before any API actions.
  # A request with valid refresh token returns an access token (temporary) and new refresh token (long lived, single use) without the user auth flow.
  # If the refresh token is not valid, we'll need to reauthorize with the user auth flow to get new tokens.
  # Returns the Teem API access token.
  def self.authorize
    refresh_token = IntegrationMetadatum.get('teem_refresh_token') || REFRESH_TOKEN
    url = "https://app.teem.com/oauth/token/?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&grant_type=refresh_token&refresh_token=#{refresh_token}"

    response = request(:post, nil, url)

    new_refresh_token = response['refresh_token']

    if new_refresh_token
      IntegrationMetadatum.put('teem_refresh_token', new_refresh_token)
      access_token = response['access_token']
    else
      access_token = self.reauthorize
    end

    return access_token
  end

  def self.reauthorize
    require 'mechanize'
    # Enable this for Mechanize debugging
    # Mechanize.log = Logger.new $stderr

    browser = Mechanize.new do |agent|
      agent.user_agent_alias = 'Mac Safari'
    end

    # Load the sign-in page
    page = browser.get("https://app.teem.com/oauth/authorize/?client_id=#{CLIENT_ID}&redirect_uri=#{REDIRECT_URI}&response_type=code&scope=users")

    # Find the link to sign in via SSO
    sign_in_link = page.links.find { |link| link.text.include? 'Sign In with Company SSO' }

    # Click that link
    page = sign_in_link.click

    # We will be prompted for our organization
    org_ask_form = page.forms[0]
    org_ask_form.fields[0].value = ORG_NAME

    # Submit that form
    page = browser.submit(page.forms.first)

    # We should be on the SSO login page now. Fill it out.
    f = page.forms[0]
    f.field_with(name: 'UserName').value = USERNAME
    f.field_with(name: 'Password').value = PASSWORD
    page = f.submit

    # We are now at a weird, no-where-place page that we just need to submit (SAML stuff?)
    f = page.forms.first
    page = f.submit

    # We should now be at teem.com being asked to Authorize
    f = page.forms.first
    authorize_btn = f.button_with(value: 'Authorize')

    the_code = nil

    page = browser.submit(f, authorize_btn)
    # After Auth, redirects to "redirect_uri/?code=string" then roles/welcome page, grab code from history
    the_code = browser.history[-2].uri.query.split("=")[1];

    url = "https://app.teem.com/oauth/token/?client_id=#{CLIENT_ID}&client_secret=#{CLIENT_SECRET}&grant_type=authorization_code&redirect_uri=#{REDIRECT_URI}&code=#{the_code}"

    response = request(:post, nil, url)

    # Save the refresh token for future use
    IntegrationMetadatum.put('teem_refresh_token', response['refresh_token'])

    return response['access_token']
  end

  def self.get_users(access_token)
    url = "https://app.teem.com/api/v4/accounts/users/"

    response = request(:get, access_token, url)
    return response['users']
  end

  def self.create_user(access_token, organization_id, email, first_name, last_name)
    url = 'https://app.teem.com/api/v4/accounts/users/'

    json_obj = { 'user' => { 'organization_id' => organization_id,
                             'email' => email.to_s,
                             'first_name' => first_name.to_s,
                             'last_name' => last_name.to_s } }.to_json

    response = request(:post, access_token, url, json_obj)
    return response['user']
  end

  def self.get_groups(access_token)
    per_page = 100
    url = "https://app.teem.com/api/v4/accounts/groups/?per_page=#{per_page}"

    response = request(:get, access_token, url)
    groups = response['groups']

    # total = response['meta']['total']
    # current_page = response['meta']['page']

    # while total > (per_page * current_page) do
    #   next_page = current_page + 1
    #   url = "https://app.teem.com/api/v4/accounts/groups/?per_page=#{per_page}&page=#{next_page}"
    #   response = request(:get, access_token, url)

    #   response['groups'].each do |group|
    #     unless group.nil?
    #       groups.push(group)
    #     end
    #   end

    #   current_page = next_page
    # end

    return groups
  end

  def self.get_API_user_info(access_token)
    url = "https://app.teem.com/api/v4/accounts/users/me/"

    response = request(:get, access_token, url)
    return response['user']
  end

  def self.create_group(access_token, organization_id, name, description = nil)
    url = "https://app.teem.com/api/v4/accounts/groups/"

    json_obj = { 'group' => { 'organization_id' => organization_id,
                              'name' => name.to_s,
                              'description' => description.to_s } }.to_json

    response = request(:post, access_token, url, json_obj)
    return response['group']
  end

  # Updates a Teem user to their list of groups is group_ids
  def self.update_user_groups(access_token, group_ids, user_id)
    url = "https://app.teem.com/api/v4/accounts/users/#{user_id}/"

    json_obj = { 'user' => { 'group_ids' => group_ids } }.to_json

    request(:patch, access_token, url, json_obj)
  end

  def self.delete_user(access_token, user_id)
    url = "https://app.teem.com/api/v4/accounts/users/#{user_id}/"

    request(:delete, access_token, url)
  end

  def self.delete_group(access_token, group_id)
    url = "https://app.teem.com/api/v4/accounts/groups/#{group_id}/"

    request(:delete, access_token, url)
  end

  def self.get_user(access_token, user_id)
    url = "https://app.teem.com/api/v4/accounts/users/#{user_id}/"

    response = request(:get, access_token, url)
    return response['user']
  end

  def self.user_ids(access_token)
    url = "https://app.teem.com/api/v4/accounts/users/id_lookup/"

    request = request(:get, access_token, url)
    return request['users']
  end
end
