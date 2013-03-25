require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class GroupsControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
  end

  test "JSON request should include certain attributes" do
    grant_test_user_basic_access

    get :show, :format => :json, :id => 2

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'

    assert body.include?('owners'), 'JSON response should include owners'
    body['owners'].each do |o|
      assert o["id"], "JSON response's 'owners' section should include an ID"
      assert o["name"], "JSON response's 'owners' section should include a name"
      assert o["loginid"], "JSON response's 'owners' section should include the login ID"
    end

    assert body.include?('operators'), 'JSON response should include operators'
    body['operators'].each do |o|
      assert o["id"], "JSON response's 'members' section should include an ID"
      assert o["name"], "JSON response's 'members' section should include a name"
      assert o["loginid"], "JSON response's 'members' section should include the login ID"
    end
    
    assert body.include?('members'), 'JSON response should include members'
    body['members'].each do |m|
      assert m["id"], "JSON response's 'members' section should include an ID"
      assert m["name"], "JSON response's 'members' section should include a name"
      assert m["loginid"], "JSON response's 'members' section should include the login ID"
    end
    
  end
end
