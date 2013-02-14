require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class PeopleControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
  end

  # loginid required for: impersonate dialog, group rule "loginid is"
  test "JSON request should include certain attributes" do
    grant_test_user_basic_access

    get :show, :format => :json, :id => 'casuser'

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response does not include id field'
    assert body.include?('name'), 'JSON response does not include name field'
    assert body.include?('type'), 'JSON response does not include type field'
    assert body.include?('loginid'), 'JSON response does not include loginid field'
    assert body.include?('roles'), 'JSON response should include roles'
  end
end
