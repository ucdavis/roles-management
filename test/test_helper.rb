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
      p.roles << r
      assert p.role_symbols.length > 0, "current_user should have just been assigned a role for this test"
    end
  end
end
