require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class GroupsControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
  end

  test "JSON request should include certain attributes" do
    grant_test_user_admin_access

    get :show, :format => :json, :id => 2

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'
    assert body.include?('description'), 'JSON response should include description field'

    assert body.include?('owners'), 'JSON response should include owners'
    body['owners'].each do |o|
      assert o["id"], "JSON response's 'owners' section should include an ID"
      assert o["name"], "JSON response's 'owners' section should include a name"
      assert o["loginid"], "JSON response's 'owners' section should include the login ID"
    end

    assert body.include?('operators'), 'JSON response should include operators'
    body['operators'].each do |o|
      assert o["id"], "JSON response's 'operators' section should include an ID"
      assert o["name"], "JSON response's 'operators' section should include a name"
      assert o["loginid"], "JSON response's 'operators' section should include the login ID"
    end
    
    assert body.include?('memberships'), 'JSON response should include memberships'
    body['memberships'].each do |m|
      assert m["id"], "JSON response's 'memberships' section should include an ID"
      assert m["name"], "JSON response's 'memberships' section should include a name"
      # loginid may be nil if the member is a group, so check for existence, not value
      assert m.has_key?("loginid"), "JSON response's 'memberships' section should include the login ID"
    end
    
  end
end
