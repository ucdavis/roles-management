ENV["RAILS_ENV"] = "test"

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'declarative_authorization/maintenance'

class ActiveSupport::TestCase
  include Authorization::TestHelper

  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Gives test user 'casuser' the basic access role for RM
  def grant_test_user_basic_access
    without_access_control do
      p = Person.find_by_loginid("casuser")
      r = Application.find_by_name("DSS Roles Management").roles.find_by_token("access")
      assert r, "DSS Roles Management 'access' token appears to be missing"
      p.roles << r unless p.roles.include? r
      assert p.role_symbols.length >= 1, "current_user should have just been assigned a role for this test"
    end
  end

  # Gives test user 'casuser' the admin access role for RM
  # Note: This also grants the 'access' token as well, as 'admin' privileges are
  #       a superset of those permissions.
  def grant_test_user_admin_access
    without_access_control do
      p = Person.find_by_loginid("casuser")
      a = Application.find_by_name("DSS Roles Management")
      r_access = a.roles.find_by_token("access")
      assert r_access, "DSS Roles Management 'access' token appears to be missing"
      p.roles << r_access unless p.roles.include? r_access
      r_admin = a.roles.find_by_token("admin")
      assert r_admin, "DSS Roles Management 'admin' token appears to be missing"
      p.roles << r_admin unless p.roles.include? r_admin
      assert p.role_symbols.length >= 2, "current_user should have just been assigned two roles for this test"
    end
  end

  def revoke_test_user_admin_access
    without_access_control do
      p = Person.find_by_loginid("casuser")
      a = Application.find_by_name("DSS Roles Management")
      r_admin = a.roles.find_by_token("admin")
      assert r_admin, "DSS Roles Management 'admin' token appears to be missing"
      p.roles.destroy(r_admin)
    end
  end

  def grant_whitelisted_access
    request.env['REMOTE_ADDR'] = '1.2.3.4'
  end

  def grant_api_user_access
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(api_key_users(:apiuser).name, api_key_users(:apiuser).secret)
  end

  def revoke_api_user_access
    request.env['HTTP_AUTHORIZATION'] = nil
  end

  # Removes all means of authentication: CAS, API whitelist, and API key
  def revoke_access
    Authorization.current_user = nil
    request.env.delete('REMOTE_ADDR')
    request.session.delete(:auth_via)
    request.session.delete(:user_id)
    CASClient::Frameworks::Rails::Filter.fake(nil)
  end

  # Ensures Authorization.current_user has no valid permission tokens to RM
  def revoke_rm_permissions
    assert Authorization.current_user, "current_user should be set before calling this function"

    without_access_control do
      p = Person.find_by_loginid("casuser")
      a = Application.find_by_name("DSS Roles Management")
      r_admin = a.roles.find_by_token("admin")
      r_access = a.roles.find_by_token("access")
      p.roles.destroy(r_admin)
      p.roles.destroy(r_access)
      p.save!
    end
  end
end
