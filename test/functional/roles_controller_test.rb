require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class RolesControllerTest < ActionController::TestCase
  # Used by RM UI when clicking on a role
  test "JSON request should include certain attributes" do
    revoke_access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    grant_test_user_admin_access
    Authorization.current_user = Person.find_by_loginid("casuser")

    get :show, :format => :json, :id => '1'

    body = JSON.parse(response.body)

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
    revoke_access
    grant_whitelisted_access

    get :show, :format => :txt, :id => '1'

    assert_response :success
  end

  test ".txt output should not include inactive users" do
    revoke_access
    grant_whitelisted_access

    inactive_p = entities(:inactivePerson)
    active_p = entities(:personWithARole)
    r = roles(:boring_role)

    assert r.members.include?(inactive_p), "role should include the inactive person"
    assert r.members.include?(active_p), "role should include the inactive person"

    assert active_p.active, "active person should be marked active"
    assert inactive_p.active == false, "inactive person should be marked inactive"

    get :show, :format => :txt, :id => r.id

    assert_response :success

    assert response.body.include?(inactive_p.email) == false, ".txt should not include inactive individual"
    assert response.body.include?(active_p.email), ".txt should include an active individual"
  end

  test "Role#update should function correctly" do
    revoke_access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    grant_test_user_admin_access
    Authorization.current_user = Person.find_by_loginid("casuser")

    @role = roles(:boring_role)

    put :update, id: @role, role: { token: 'not boring' }, :format => :json

    assert_response :success
  end

  test "assigning an entity to a role touches the timestamp on it's application" do
    revoke_access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    grant_test_user_admin_access
    Authorization.current_user = Person.find_by_loginid("casuser")

    r = Role.first
    p = Person.find_by_loginid('bob')

    assert r.members.include?(p) == false, "role should not include person"
    assert r.application != nil, "role should have an application"
    application_timestamp = r.application.updated_at

    p.roles << r
    r.reload
    assert r.members.include?(p) == true, "role should include person now"

    assert r.application.updated_at > application_timestamp, "application timestamp should have been udpated"
  end

  test "un-assigning an entity to a role touches the timestamp on it's application" do
    revoke_access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    grant_test_user_admin_access
    Authorization.current_user = Person.find_by_loginid("casuser")

    r = Role.first
    p = Person.find_by_loginid('bob')

    assert r.members.include?(p) == false, "role should not include person"
    assert r.application != nil, "role should have an application"

    p.roles << r
    r.reload
    assert r.members.include?(p) == true, "role should include person now"
    application_timestamp = r.application.updated_at

    p.roles.delete(r)
    r.reload

    assert r.application.updated_at > application_timestamp, "application timestamp should have been udpated"
  end

  test "assigning an entity to a role touches the timestamp on the role" do
    revoke_access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    grant_test_user_admin_access
    Authorization.current_user = Person.find_by_loginid("casuser")

    r = Role.first
    p = Person.find_by_loginid('bob')

    assert r.members.include?(p) == false, "role should not include person"
    assert r.application != nil, "role should have an application"
    role_timestamp = r.updated_at

    p.roles << r
    r.reload
    assert r.members.include?(p) == true, "role should include person now"

    assert r.updated_at > role_timestamp, "role timestamp should have been udpated"
  end

  test "un-assigning an entity to a role touches the timestamp on the role" do
    revoke_access
    CASClient::Frameworks::Rails::Filter.fake("casuser")
    grant_test_user_admin_access
    Authorization.current_user = Person.find_by_loginid("casuser")

    r = Role.first
    p = Person.find_by_loginid('bob')

    assert r.members.include?(p) == false, "role should not include person"
    assert r.application != nil, "role should have an application"

    p.roles << r
    r.reload
    assert r.members.include?(p) == true, "role should include person now"
    role_timestamp = r.updated_at

    p.roles.delete(r)
    r.reload

    assert r.updated_at > role_timestamp, "application timestamp should have been udpated"
  end
end
