require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class PeopleControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
  end

  # Required for various AJAX requests which search against a database of login IDs
  # e.g. impersonate dialog, group rule "loginid is"
  test "JSON request should include loginid" do
    grant_test_user_basic_access

    get :index, :format => :json

    body = JSON.parse(response.body)[0]
    assert body.include?('loginid'), 'JSON response does not include loginid field'
  end
end
