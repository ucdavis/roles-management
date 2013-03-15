require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class PeopleControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
  end

  # loginid required for: impersonate dialog, group rule "loginid is"
  # id, name, loginid, email, roles included as per published API spec
  test "JSON request should include certain attributes" do
    grant_test_user_basic_access

    get :show, :format => :json, :id => 'casuser'

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'
    assert body.include?('email'), 'JSON response should include email field'
    assert body.include?('type'), 'JSON response should include type field'
    assert body.include?('loginid'), 'JSON response should include loginid field'
    assert body.include?('roles'), 'JSON response should include roles'
  end
end
