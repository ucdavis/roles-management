require 'test_helper'

class Api::V1::PeopleControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(api_key_users(:apiuser).name, api_key_users(:apiuser).secret)
  end

  # loginid required for: impersonate dialog, group rule "loginid is"
  # id, name, loginid, email, roles included as per published API spec
  # Should also respond to /people/loginid.json
  test 'JSON show request should include certain attributes' do
    grant_test_user_admin_access

    get :show, :format => :json, :id => 'casuser'

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'
    assert body.include?('email'), 'JSON response should include email field'
    assert body.include?('type'), 'JSON response should include type field'
    assert body.include?('loginid'), 'JSON response should include loginid field'
    assert body.include?('title'), 'JSON response should include title field'

    assert body.include?('affiliations'), 'JSON response should include affiliations'
    body['affiliations'].each do |r|
      assert r['name'], "JSON response's 'affiliations' section should include a name"
    end

    assert body.include?('organizations'), 'JSON response should include organizations'
    body['organizations'].each do |o|
      assert o['id'], "JSON response's 'organizations' section should include an ID"
      assert o['name'], "JSON response's 'organizations' section should include a name"
      assert o['code'], "JSON response's 'organizations' section should include a code"
    end

    assert body.include?('role_assignments'), 'JSON response should include role_assignments'
    body['role_assignments'].each do |r|
      assert r['role_id'], "JSON response's 'role_assignments' section should include a role_id field" # we cannot call it 'id' because Backbone won't add it twice then, which we _do_ want due to a person possibly having a role both explicitly and non-explicitly
      assert r['token'], "JSON response's 'role_assignments' section should include a token"
      assert r['name'], "JSON response's 'role_assignments' section should include a name"
      assert r['application_id'], "JSON response's 'role_assignments' section should include an application_id"
    end

    assert body.include?('group_memberships'), 'JSON response should include group_memberships'
    body['group_memberships'].each do |r|
      assert r['group_id'], "JSON response's 'group_memberships' section should include a group_id field"
      assert r['id'], "JSON response's 'group_memberships' section should include an id"
      assert r['name'], "JSON response's 'group_memberships' section should include a name"
      assert r.has_key?('ou'), "JSON response's 'group_memberships' section should include ou field"
    end

    assert body.include?('group_ownerships'), 'JSON response should include group_ownerships'
    body['group_ownerships'].each do |r|
      assert r['group_id'], "JSON response's 'group_ownerships' section should include a group_id field"
      assert r['id'], "JSON response's 'group_ownerships' section should include an id"
      assert r['name'], "JSON response's 'group_ownerships' section should include a name"
    end

    assert body.include?('group_operatorships'), 'JSON response should include group_operatorships'
    body['group_operatorships'].each do |r|
      assert r['group_id'], "JSON response's 'group_operatorships' section should include a group_id field"
      assert r['id'], "JSON response's 'group_operatorships' section should include an id"
      assert r['name'], "JSON response's 'group_operatorships' section should include a name"
    end
  end

  test 'JSON show request should work via login ID' do
    grant_api_user_access

    get :show, :format => :json, :id => 'casuser'

    assert_response :success
  end

  test 'JSON show request should work via numeric ID' do
    grant_api_user_access

    get :show, :format => :json, :id => 1

    assert_response :success

    body = JSON.parse(response.body)

    assert body['id'] == 1, 'JSON response should have requested ID'
    assert body['loginid'] == 'casuser', 'JSON response should have correct login ID'
  end

  test "JSON show request should not include inactive entities" do
    grant_api_user_access

    inactiveEntity = entities(:inactivePerson)

    get :show, :format => :json, :id => inactiveEntity.id

    assert_response :missing
  end

  test "unauthenticated requests should not be honored" do
    revoke_access

    get :show, :format => :json, :id => 'casuser'

    assert_response 401
  end
end
