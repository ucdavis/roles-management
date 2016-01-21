require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class ApplicationsControllerTest < ActionController::TestCase
  setup do
    CASClient::Frameworks::Rails::Filter.fake("casuser")

    Authorization.current_user = Person.find_by_loginid('casuser')
  end

  test "valid cas user with no roles should get denied" do
    Authorization.current_user.roles.delete_all # ensure they have no roles
    puts Authorization.current_user.role_symbols
    assert Authorization.current_user.role_symbols.length == 0, "current_user should not have had any roles for this test"
    get :index
    assert_redirected_to(:controller => "site", :action => "access_denied")
  end

  test "valid cas user with access role should get index" do
    grant_test_user_basic_access

    get :index

    assert_response :success
    assert_not_nil assigns(:applications)
  end

  test "JSON request should include certain attributes" do
    grant_test_user_admin_access

    get :show, :format => :json, :id => '1'

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response does not include id field'
    assert body.include?('name'), 'JSON response does not include name field'
    assert body.include?('description'), 'JSON response does not include description field'
    assert body.include?('roles'), 'JSON response should include roles'

    # body['roles'] should include entities which include name and id (for frontend interface role assignment, applicaiton saving, and new role creation saving (temp ID -> real ID), etc.)
    body['roles'].each do |r|
      assert r["id"], "JSON response's 'roles' section should include an ID field"
      assert r["name"], "JSON response's 'roles' section should include a name field"
      assert r["token"], "JSON response's 'roles' section should include a token field"
      assert r["description"], "JSON response's 'roles' section should include a description field"
      # ad_path may be nil so check for existence not value
      assert r.has_key?("ad_path"), "JSON response's 'roles' section should include an ad_path field"
    end

    assert body["owners"], "JSON response should include an 'owners' section"
    body["owners"].each do |o|
      assert o["id"], "JSON response's 'owners' section's 'members' should include an ID"
      assert o["name"], "JSON response's 'owners' section's 'members' should include a name"
    end

    assert body["operatorships"], "JSON response should include an 'operatorships' section"
    body["operatorships"].each do |o|
      assert o["id"], "JSON response's 'operatorships' section should include an ID"
      assert o["name"], "JSON response's 'operatorships' section should include a name"
    end
  end

  test "application CSV request should not include inactive members" do
    grant_test_user_admin_access

    inactive_p = entities(:inactivePerson)
    active_p = entities(:personWithARole)
    a = applications(:regular_app)

    assert a.roles.length == 1, "application should have one role"
    r = a.roles[0]

    assert r.members.include?(inactive_p), "role should include the inactive person"
    assert r.members.include?(active_p), "role should include the inactive person"

    assert active_p.active, "active person should be marked active"
    assert inactive_p.active == false, "inactive person should be marked inactive"

    get :show, :format => :csv, :id => a.id

    assert response.body.include?(inactive_p.loginid) == false, "CSV should not include inactive individual"
    assert response.body.include?(active_p.loginid), "CSV should include an active individual"
  end

  test "updating a role touches the timestamp on it's application" do
    grant_test_user_admin_access

    a = Application.find_by_id(2)
    application_timestamp = a.updated_at

    assert a.roles.length == 1, "application should have one role"
    r = a.roles[0]

    r.touch

    a = Application.find_by_id(2)

    assert a.updated_at > application_timestamp, "application timestamp should have updated"
  end

  test "creating a role touches the timestamp on it's application" do
    grant_test_user_admin_access

    a = Application.find_by_id(2)
    application_timestamp = a.updated_at

    r = Role.new
    r.token = "something"
    r.name = "Something"
    r.description = "Does something"
    r.application = a
    r.save!

    a = Application.find_by_id(2)

    assert a.updated_at > application_timestamp, "application timestamp should have updated"
  end

  test "deleting a role touches the timestamp on it's application" do
    grant_test_user_admin_access

    a = Application.find_by_id(2)

    r = Role.new
    r.token = "something"
    r.name = "Something"
    r.description = "Does something"
    r.application = a
    r.save!

    a = Application.find_by_id(2)
    application_timestamp = a.updated_at

    # Delete the role
    r.destroy

    a = Application.find_by_id(2)

    assert a.updated_at > application_timestamp, "application timestamp should have updated"
  end

  test "assigning an owner touches the timestamp on the application" do
    grant_test_user_admin_access

    a = Application.find_by_id(2)
    application_timestamp = a.updated_at

    p = Person.first
    assert a.owners.include?(p) == false, "person should not already be an owner"

    a.owners << p
    assert a.owners.include?(p) == true, "person should now be an owner"

    a = Application.find_by_id(2)
    assert a.updated_at > application_timestamp, "application timestamp should have updated"
  end

  test "un-assigning an owner touches the timestamp on the application" do
    grant_test_user_admin_access

    a = Application.find_by_id(2)
    application_timestamp = a.updated_at

    p = Person.first
    assert a.owners.include?(p) == false, "person should not already be an owner"

    a.owners << p
    assert a.owners.include?(p) == true, "person should now be an owner"

    a = Application.find_by_id(2)
    a.owners.delete(p)
    assert a.owners.include?(p) == false, "person should not be an owner anymore"

    a = Application.find_by_id(2)
    assert a.updated_at > application_timestamp, "application timestamp should have updated"
  end

  test "assigning an operator touches the timestamp on the application" do
    grant_test_user_admin_access

    a = Application.find_by_id(2)
    application_timestamp = a.updated_at

    p = Person.first
    assert a.operators.include?(p) == false, "person should not already be an operator"

    a.operators << p
    assert a.operators.include?(p) == true, "person should now be an operator"

    a = Application.find_by_id(2)
    assert a.updated_at > application_timestamp, "application timestamp should have updated"
  end

  test "un-assigning an operator touches the timestamp on the application" do
    grant_test_user_admin_access

    a = Application.find_by_id(2)
    application_timestamp = a.updated_at

    p = Person.first
    assert a.operators.include?(p) == false, "person should not already be an operator"

    a.operators << p
    assert a.operators.include?(p) == true, "person should now be an operator"

    a = Application.find_by_id(2)
    a.operators.delete(p)
    assert a.operators.include?(p) == false, "person should not be an operator anymore"

    a = Application.find_by_id(2)
    assert a.updated_at > application_timestamp, "application timestamp should have updated"
  end

  test "universal operator should see all applications except DSS RM" do
    @person = entities(:casuser)

    revoke_test_user_basic_access
    revoke_test_user_admin_access
    grant_test_user_operate_access

    with_user(@person) do
      assert @person.manageable_applications.length == (Application.count - 1), "Universal operator should see all applications except DSS RM"
    end
  end
end
