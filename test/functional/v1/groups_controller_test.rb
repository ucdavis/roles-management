require 'test_helper'

class Api::V1::GroupsControllerTest < ActionController::TestCase
  setup do
    request.env['HTTP_AUTHORIZATION'] = ActionController::HttpAuthentication::Basic.encode_credentials(api_key_users(:apiuser).name, api_key_users(:apiuser).secret)
  end

  test 'JSON show request should include certain attributes' do
    grant_test_user_admin_access

    get :show, :format => :json, :id => 2

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
  end

  test "unauthenticated requests should not be honored" do
    revoke_access

    get :show, :format => :json, :id => 'casuser'

    assert_response 401
  end
end
