require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class RolesControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
  end

  test "JSON request should include certain attributes" do
    grant_test_user_basic_access

    get :show, :format => :json, :id => '1'

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response does not include id field'
    assert body.include?('token'), 'JSON response does not include token field'
    assert body.include?('name'), 'JSON response does not include name field'
    assert body.include?('application_id'), 'JSON response does not include application_id field'
    assert body.include?('description'), 'JSON response should include description'
    assert body.include?('entities'), 'JSON response should include entities'
    assert body.include?('members'), 'JSON response should include members'
    
    # body['roles'] should include entities which include name and id (for frontend interface role assignment, applicaiton saving, and new role creation saving (temp ID -> real ID), etc.)
    body['entities'].each do |e|
      assert e["id"], "JSON response's 'roles' section's 'entities' should include an ID"
      assert e["name"], "JSON response's 'roles' section's 'entities' should include a name"
      assert e["type"], "JSON response's 'roles' section's 'entities' should include a type"
    end
    body['members'].each do |m|
      assert m["id"], "JSON response's 'roles' section's 'members' should include an ID"
      assert m["name"], "JSON response's 'roles' section's 'members' should include a name"
    end
  end

  test ".txt output should work for a particular role" do
    grant_whitelisted_access

    get :show, :format => :txt, :id => '1'

  end
end
