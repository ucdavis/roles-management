require 'test_helper'

class Api::V1::GroupMembershipsControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(api_key_users(:apiuser).name, api_key_users(:apiuser).secret)
  end

  test 'JSON create request should work' do
    grant_test_user_admin_access

    assert_difference('GroupMembership.count') do
      post :create, { entity_id: 14, group_id: 2, format: :json }
    end

    body = JSON.parse(response.body)

    assert body.include?('id'), 'JSON response should include id field'
  end

  test 'JSON destroy request should work' do
    revoke_access
    grant_api_user_access

    assert_difference('GroupMembership.count', -1) do
      delete :destroy, { group_id: 2, id: 5, format: :json }
    end
  end

  test "unauthenticated requests should not be honored" do
    revoke_access

    delete :destroy, { group_id: 2, id: 5, format: :json }

    assert_response 401
  end
end
