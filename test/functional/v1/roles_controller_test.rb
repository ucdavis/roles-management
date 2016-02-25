require 'test_helper'

# These tests are run using the fake CAS user 'casuser'
class Api::V1::RolesControllerTest < ActionController::TestCase
  test "JSON show request should include certain attributes" do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(api_key_users(:apiuser).name, api_key_users(:apiuser).secret)

    get :show, :format => :json, :id => '1'

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response does not include id field'
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

  test "JSON show request should not include inactive entities" do
    grant_api_user_access

    inactiveEntity = entities(:inactivePerson)

    assert inactiveEntity.roles.length > 0, "inactive entity fixture needs at least one role"

    get :show, :format => :json, :id => inactiveEntity.roles[0].id

    role = JSON.parse(response.body)

    role["members"].each do |m|
      assert m["id"].to_i != inactiveEntity.id, "JSON response should not include inactive entity"
    end
  end

  test "Activating/de-activating a person should invalid role view caches (touch appropriate role and role assignment objects)" do
    inactiveEntity = entities(:inactivePerson)

    assert inactiveEntity.active == false, "inactive entity should be inactive at the start of the test. Check the fixture."

    # The following two lines are equivalent but it doesn't hurt to do have extra testing
    assert inactiveEntity.roles.length > 0, "inactive entity fixture needs at least one role"
    assert inactiveEntity.role_assignments.length > 0, "inactive entity fixture needs at least one role assignment"

    # Save the last modified time for an inactive entity's role
    roleAssignment = inactiveEntity.role_assignments.first
    assignedRole = roleAssignment.role

    roleAssignment_mtime = roleAssignment.updated_at
    role_mtime = assignedRole.updated_at

    # Switch the 'active' status on the entity and ensure the role was updated
    inactiveEntity.active = true
    inactiveEntity.save!

    assert inactiveEntity.role_assignments.first.updated_at > roleAssignment_mtime, "role assignment should have been touched due to active/inactive change"
    assert inactiveEntity.role_assignments.first.role.updated_at > role_mtime, "role should have been touched due to active/inactive change"
  end
end
