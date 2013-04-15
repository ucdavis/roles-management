require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class PeopleControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    @person = entities(:casuser)
  end

  # loginid required for: impersonate dialog, group rule "loginid is"
  # id, name, loginid, email, roles included as per published API spec
  # Should also respond to /people/loginid.json
  test 'JSON request should include certain attributes' do
    grant_test_user_admin_access

    get :show, :format => :json, :id => 'casuser'

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'
    assert body.include?('email'), 'JSON response should include email field'
    assert body.include?('type'), 'JSON response should include type field'
    assert body.include?('loginid'), 'JSON response should include loginid field'

    assert body.include?('roles'), 'JSON response should include roles'
    body["roles"].each do |r|
      assert r["id"], "JSON response's 'roles' section should include an ID"
      assert r["token"], "JSON response's 'roles' section should include a token"
      assert r["name"], "JSON response's 'roles' section should include a name"
      assert r["application_id"], "JSON response's 'roles' section should include an application_id"
    end
  end
  
  test "should update person" do
    put :update, id: @person, format: :json, person: { first: @person.first, last: @person.last, loginid: @person.loginid }
    assert_response :success
  end
end
