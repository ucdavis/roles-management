require 'test_helper'

class Admin::OpsControllerTest < ActionController::TestCase
  test 'admin access required impersonating' do
    # Ensure unauthorized user has no access
    revoke_access

    get 'impersonate', params: { loginid: 'someone' }, as: :json
    assert_response 401

    # Ensure authorized non-admin user has no access
    CASClient::Frameworks::Rails::Filter.fake('casuser')

    grant_test_user_basic_access
    revoke_test_user_admin_access

    get 'impersonate', params: { loginid: 'someone' }, as: :json
    assert_response 403
  end

  test 'admins can impersonate' do
    CASClient::Frameworks::Rails::Filter.fake('casuser')

    # Ensure authorized admin users have access
    grant_test_user_admin_access

    get 'impersonate', params: { loginid: 'someone' }
    assert_response :redirect
  end
end
