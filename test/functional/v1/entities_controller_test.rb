require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class Api::V1::EntitiesControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    @person = entities(:casuser)
  end

  # loginid required for: impersonate dialog, group rule "loginid is"
  # id, name, loginid, email, roles included as per published API spec
  # Should also respond to /people/loginid.json
  test 'JSON request should include certain attributes' do
    grant_test_user_admin_access

    get :index, :format => :json

    body = JSON.parse(response.body)[0]

    assert body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'
    assert body.include?('type'), 'JSON response should include type field'
    assert body.include?('loginid'), 'JSON response should include loginid field'
  end
end
