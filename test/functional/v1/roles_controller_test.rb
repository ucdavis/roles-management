require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class Api::V1::RolesControllerTest < ActionController::TestCase
  test "JSON request should include certain attributes" do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    grant_test_user_admin_access
  
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
    end
  end
end
