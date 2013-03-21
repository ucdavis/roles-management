require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class ApplicationsControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")
  end

  test "valid cas user with no roles should get denied" do
    get :index
    assert Authorization.current_user.role_symbols.length == 0, "current_user should not have had any roles for this test"
    assert_redirected_to(:controller => "site", :action => "access_denied")
  end

  test "valid cas user with access role should get index" do
    grant_test_user_basic_access

    get :index

    assert_response :success
    assert_not_nil assigns(:applications)
  end

  test "JSON request should include certain attributes" do
    grant_test_user_basic_access

    get :show, :format => :json, :id => '1'

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response does not include id field'
    assert body.include?('name'), 'JSON response does not include name field'
    assert body.include?('roles'), 'JSON response should include roles'
    
    # body['roles'] should include entities which include name and id (for frontend interface role assignment, applicaiton saving, and new role creation saving (temp ID -> real ID), etc.)
    body['roles'].each do |r|
      assert r["entities"], "JSON response's 'roles' section should include an 'entities' section"
      assert r["members"], "JSON response's 'roles' section should include a 'members' section"
      r["entities"].each do |e|
        assert e["id"], "JSON response's 'roles' section's 'entities' should include an ID"
        assert e["name"], "JSON response's 'roles' section's 'entities' should include a name"
        assert e["type"], "JSON response's 'roles' section's 'entities' should include a type"
      end
      r["members"].each do |m|
        assert m["id"], "JSON response's 'roles' section's 'members' should include an ID"
        assert m["name"], "JSON response's 'roles' section's 'members' should include a name"
      end
    end
  end
end
