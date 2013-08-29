require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class Api::V1::EntitiesControllerTest < ActionController::TestCase
  test "unauthenticated user should redirected to cas" do
    revoke_all_access
    
    assert @request.env['REMOTE_ADDR'] != '1.2.3.4'
    # Even if we unset Authorization.current_user, declarative_authorization sets it as "AnonymousUser" with role :guest, so check for that instead of nil
    assert Authorization.current_user.role_symbols.include?(:guest), "current_user should have :guest role for this test"
    assert Authorization.current_user.role_symbols.length == 1, "current_user should not have more than :guest role for this test"
    assert session[:auth_via] != :cas, "authentication should not be set"
  
    # We have to pass 'auth_via' as '' to ensure it is set to an empty string
    # in the session. Deleting session keys doesn't appear to work nor does
    # setting 'auth_via' to nil. I'd love to know why.
    get :index, nil, { 'auth_via' => '' }, nil
  
    assert_response 403
  end

  test "valid API whitelisted user should get index" do
    grant_whitelisted_access
  
    get :index
  
    assert_response :success
    assert_not_nil assigns(:entities)
  end
  
  # loginid required for: impersonate dialog, group rule "loginid is"
  # id, name, loginid, email, roles included as per published API spec
  # Should also respond to /people/loginid.json
  test 'JSON request should include certain attributes' do
    grant_whitelisted_access
  
    get :index, :format => :json
  
    body = JSON.parse(response.body)[0]
  
    assert body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'
    assert body.include?('type'), 'JSON response should include type field'
    assert body.include?('loginid'), 'JSON response should include loginid field'
  end

  test 'JSON show request should include certain attributes when entity is a person' do
    grant_whitelisted_access
  
    get :show, :format => :json, :id => 1
  
    body = JSON.parse(response.body)
  
    refute body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'
    assert body.include?('type'), 'JSON response should include type field'
    assert body.include?('email'), 'JSON response should include email field'
    refute body.include?('loginid'), 'JSON response should include loginid field'
    
    refute body.include?('members'), 'JSON response should not include members'
  end

  test 'JSON show request should include certain attributes when entity is a group' do
    grant_whitelisted_access
  
    get :show, :format => :json, :id => 2
  
    body = JSON.parse(response.body)
  
    refute body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'
    assert body.include?('type'), 'JSON response should include type field'
    refute body.include?('loginid'), 'JSON response should include loginid field'
    
    assert body.include?('members'), 'JSON response should include members'
    body["members"].each do |m|
      assert m["id"], "JSON response's 'members' section should include an id"
      assert m["type"], "JSON response's 'members' section should include a type"
    end
  end
end
