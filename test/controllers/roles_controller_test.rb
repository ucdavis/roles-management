require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class RolesControllerTest < ActionController::TestCase
  # Used by RM UI when clicking on a role
  test 'JSON request should include certain attributes' do
    revoke_access
    CASClient::Frameworks::Rails::Filter.fake('casuser')
    grant_test_user_admin_access

    get :show, params: { id: 1 }, as: :json

    body = JSON.parse(response.body)

    assert body.include?('assignments'), 'JSON response should include assignments'
    # body['assignments'] should include certain attributes
    body['assignments'].each do |e|
      assert e['id'], "JSON response's 'roles' section's 'assignments' should include id"
      assert e['entity_id'], "JSON response's 'roles' section's 'assignments' should include entity_id"
      assert e.key?('calculated'), "JSON response's 'roles' section's 'assignments' should include the calculated flag"
      assert e['name'], "JSON response's 'roles' section's 'assignments' should include a name"
      assert e['type'], "JSON response's 'roles' section's 'assignments' should include a type"
    end
  end

  test '.txt output should work for a particular role' do
    revoke_access
    grant_whitelisted_access

    get :show, params: { id: 1 }, as: :txt

    assert_response :success
  end

  test '.txt output should not include inactive users' do
    revoke_access
    grant_whitelisted_access

    inactive_p = entities(:inactivePerson)
    active_p = entities(:personWithARole)
    r = roles(:boring_role)

    assert r.members.include?(inactive_p), 'role should include the inactive person'
    assert r.members.include?(active_p), 'role should include the inactive person'

    assert active_p.active, 'active person should be marked active'
    assert inactive_p.active == false, 'inactive person should be marked inactive'

    get :show, params: { id: r.id }, as: :txt

    assert_response :success

    assert response.body.include?(inactive_p.email) == false, '.txt should not include inactive individual'
    assert response.body.include?(active_p.email), '.txt should include an active individual'
  end
end
