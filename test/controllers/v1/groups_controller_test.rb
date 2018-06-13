require 'test_helper'

class Api::V1::GroupsControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(api_key_users(:apiuser).name, api_key_users(:apiuser).secret)
  end

  test 'JSON show request should include certain attributes' do
    grant_test_user_admin_access

    get :show, params: { id: 2 }, as: :json

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response should include id field'
    assert body.include?('name'), 'JSON response should include name field'

    assert body.include?('members'), 'JSON response should include members'
    body['members'].each do |m|
      assert m['id'], "JSON response's 'members' section should include an ID"
      assert m['name'], "JSON response's 'members' section should include a name"
      assert m['type'], "JSON response's 'members' section should include a type"
      if m['type'] == 'Person'
        assert m['email'], "JSON response's 'members' section should include an email"
      end
    end

    assert body.include?('memberships'), 'JSON response should include memberships'
    body['memberships'].each do |m|
      assert m['id'], "JSON response's 'memberships' section should include an ID"
      assert m['entity_id'], "JSON response's 'memberships' section should include an entity ID"
    end
  end

  test 'JSON update request should work' do
    revoke_access
    grant_api_user_access

    @group = entities(:groupA)

    patch :update, params: { id: @group, group_attributes: { name: 'New Name' } }
    assert_response :success

    @group.reload

    #assert @group.name == 'New Name'
  end

  test 'unauthenticated requests should not be honored' do
    revoke_access

    get :show, params: { id: 'casuser' }, as: :json

    assert_response 401
  end
end
