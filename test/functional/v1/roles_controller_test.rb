require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class Api::V1::RolesControllerTest < ActionController::TestCase
  test "JSON show request should include certain attributes" do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(api_key_users(:apiuser).name, api_key_users(:apiuser).secret)
    
    get :show, :format => :json, :id => '1'
    
    body = JSON.parse(response.body)
    
    refute body.include?('id'), 'JSON response does not include id field'
    assert body.include?('token'), 'JSON response does not include token field'
    assert body.include?('name'), 'JSON response does not include name field'
    assert body.include?('application_id'), 'JSON response does not include application_id field'
    assert body.include?('description'), 'JSON response should include description'
    
    assert body.include?('members'), 'JSON response should include members'
    # body['assignments'] should include certain attributes
    body['members'].each do |e|
      assert e['id'], "JSON response 'members' section should include id"
      assert e['loginid'], "JSON response 'members' section should include loginid"
      assert e['name'], "JSON response 'members' section should include name"
    end
  end
  
  test "JSON show request should not include disabled entities" do
    grant_api_user_access

    disabledEntity = entities(:disabledPerson)
    
    assert disabledEntity.roles.length > 0, "disabled entity fixture needs at least one role"

    get :show, :format => :json, :id => disabledEntity.roles[0].id

    role = JSON.parse(response.body)

    role["members"].each do |m|
      assert m["id"].to_i != disabledEntity.id, "JSON response should not include disabled entity"
    end
  end
end
