require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class RolesControllerTest < ActionController::TestCase
  test "JSON request should include certain attributes" do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    
    grant_test_user_admin_access
  
    get :show, :format => :json, :id => '1'
  
    body = JSON.parse(response.body)
  
    assert body.include?('id'), 'JSON response does not include id field'
    assert body.include?('token'), 'JSON response does not include token field'
    assert body.include?('name'), 'JSON response does not include name field'
    assert body.include?('application_id'), 'JSON response does not include application_id field'
    assert body.include?('description'), 'JSON response should include description'
    
    assert body.include?('assignments'), 'JSON response should include assignments'
    # body['assignments'] should include certain attributes
    body['assignments'].each do |e|
      assert e['id'], "JSON response's 'roles' section's 'assignments' should include id"
      assert e['entity_id'], "JSON response's 'roles' section's 'assignments' should include entity_id"
      assert e.has_key?('calculated'), "JSON response's 'roles' section's 'assignments' should include the calculated flag"
      assert e['name'], "JSON response's 'roles' section's 'assignments' should include a name"
      assert e['type'], "JSON response's 'roles' section's 'assignments' should include a type"
    end
  end

  test ".txt output should work for a particular role" do
    grant_whitelisted_access

    get :show, :format => :txt, :id => '1'
    
    assert_response :success
  end
end
